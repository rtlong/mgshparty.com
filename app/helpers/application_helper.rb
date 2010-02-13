# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def admin_link_to(link_text, link_object)
    if logged_in?
      link_to link_text, [:admin, link_object]
    else
      link_text
    end
  end
  
  def controllers_for_nav
    [ :businesses, :business_types, :contributions ]
  end
end
