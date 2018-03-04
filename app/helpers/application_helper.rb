module ApplicationHelper

  def copyright_generator
    @copyright = ReillyViewTool::Renderer.copyright 'Simon Reilly', 'All rights reserved'
  end

  def login_helper style = 'active-link'
    if current_user.is_a?(GuestUser)
      (link_to 'Log in', new_user_session_path, class: style) +
        (link_to 'Register', new_user_registration_path, class: style)
    else
      link_to 'log out', destroy_user_session_path, class: style, method: :delete
    end
  end

  def source_helper(layout_name)
    greeting = "Thanks for visiting me from #{session[:source]} and you are on the #{layout_name} layout"
    content_tag(:p, greeting, class: 'source-greeting') if session[:source]
  end


  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
