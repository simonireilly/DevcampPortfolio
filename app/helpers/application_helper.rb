module ApplicationHelper
  def login_helper
    if current_user.is_a?(User)
      link_to 'log out', destroy_user_session_path, method: :delete
    else
      (link_to 'Log in', new_user_session_path) +
      content_tag(:br) +
      (link_to 'Register', new_user_registration_path)
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
