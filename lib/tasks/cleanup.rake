namespace :db do
  namespace :cleanup do
    desc "Cleanup and normalize all the businesses' addressing fields. Will also find the proper zip code"
    task :businesses => :environment do
      a = Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'
      }  
      page = a.get('http://zip4.usps.com/zip4/company_zip.jsp')
      
      for business in Business.not_responded.all(:conditions => "mailing_required = true")
        puts "#{business.id}: " + [business.name, business.contact_name, business.contact_department, business.street, business.city, business.state, business.zip].join("; ")
        
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
          
          address_match = /(\w[\w\ ]+\w)[\n\r\t]+([\w\ ]+)[\302\240\ ]+(\w{2})[\302\240\ \n\t\r]+(\d{5}-\d{4})/.match(address)
          if address_match 
            [business.name, business.contact_name, business.contact_department]
            business.street = address_match[1].titleize
            business.city = address_match[2].titleize
            business.state = address_match[3]
            business.zip = address_match[4]
            
            puts " => #{business.id}: " + [business.name, business.contact_name, business.contact_department, business.street, business.city, business.state, business.zip].join("; ")
          else
            puts " => #{business.id}: Error! '#{address}'"
          end
          
        end
      end
    end
  end  
end
