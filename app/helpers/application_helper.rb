# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def link_to_if_logged_in(link_text, *link_params)
    if logged_in?
      link_to link_text, *link_params
    else
      link_text
    end
  end
  
  def controllers_for_nav
    [ :businesses, :business_types, :contributions ]
  end
end
