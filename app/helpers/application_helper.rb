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
  
  def client_browser_type
    case request.env['HTTP_USER_AGENT'].downcase
    when /msie/i then :ie
    when /konqueror/i then :konqueror
    when /gecko/i then :mozilla
    when /opera/i then :opera
    when /applewebkit/i then :webkit
    else 
      :unknown
    end
  end
  
  def client_browser_is_ie_or_unknown
    [:ie, :unknown].include? client_browser_type
  end
  
  def email_client_info
    lines = %w( REMOTE_ADDR REMOTE_HOST REQUEST_URI HTTP_USER_AGENT HTTP_REFERER ).collect do |var|
      [var, request.env[var]].join(": ")
    end
    body = "\n\n\n\nThe following info will be helpful for the webmaster to assist you. Please leave it in the email.\n"
    body << lines.join("\n")
  end
end
