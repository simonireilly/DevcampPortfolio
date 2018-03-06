module ApplicationHelper

  def nav_items
    [
        {
            url: root_path,
            title: 'Home'
        },
        {
            url: about_path,
            title: 'About me'
        },
        {
            url: contact_path,
            title: 'Contact'
        },
        {
            url: blogs_path,
            title: 'Blog'
        },
        {
            url: portfolios_path,
            title: 'Portfolio'
        }
    ]
  end

  def nav_helper style, tag_type
    nav_links = ''
    nav_items.each do |item|
      nav_links <<
        content_tag(tag_type,
                   (link_to item[:title], item[:url], class: (style + active?(item[:url]).to_s))
                   )
    end
    nav_links.html_safe
  end

  def active? path
    ' active' if current_page? path
  end

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
