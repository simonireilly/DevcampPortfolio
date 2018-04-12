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
        },
        {
            url: tech_news_path,
            title: 'Tech News'
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

  def source_helper(style)
    greeting = "Thanks for visiting me from #{session[:source]},
                please feel free to #{link_to 'contact me', contact_path} if you would like to work together"
    content_tag(:div, greeting.html_safe, class: style) if session[:source]
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

  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])
    if alert
      alert_generator(alert)
    end
  end

  def alert_generator(msg)
    js add_gritter(msg, title: 'Notification', sticky: false)
  end
end
