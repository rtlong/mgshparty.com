require 'mechanize'

namespace :db do
  desc "Export all businesses needing to be mailed"
  task :dump_addresses => :environment do
    a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }  
    page = a.get('http://zip4.usps.com/zip4/company_zip.jsp')
    for business in Business.not_responded.all(:conditions => "mailing_required = true")
      a.transact do
        search_result = page.form_with(:name => 'form1') do |search|
          search.firmname = business.name
          search.address2 = business.street
          search.address1 = business.street2
          search.city = business.city
          search.state = business.state
          search.zip5 = business.zip
        end.submit
        
        full_td_element = search_result.search('.//table[@summary="This table contains an exact match address and ZIP code."]//td[@headers]').inner_text
        first_of_multiple_tds = search_result.search('.//table[@summary="This table contains multiple addresses and ZIP codes."]//tr[1]').inner_text
        address = full_td_element + first_of_multiple_tds
        address_match = /(\w[\w\ ]+\w)[\n\r\t]+([\w\ ]+)[\302\240\ ]+(\w{2})[\302\240\ \n\t\r]+(\d{5}-\d{4})/.match address
        if address_match 
          puts [business.name, business.contact_name, business.contact_department].push(address_match[1..4]).flatten.join "\t"
        else
          puts "error on business #{business.id}: #{address}"
        end
      end
    end
  end
end


search_result = ''

