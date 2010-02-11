module Admin::BusinessesHelper
  def set_mailing_required(business_id)
    update_page do |page|
        value = page["business_#{business_id}_mailing_required"].value
        page.alert "#{business_id}: #{value}" #"true"
  #do some stuff
      #else
      #  page.alert "false"
  #do some other stuff
      #end
    end
  end
end
