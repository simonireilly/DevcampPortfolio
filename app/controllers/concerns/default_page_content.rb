module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  def set_page_defaults
    @page_title = 'DevcampPortfolio | Z-blog'
    @seo_keywords = 'Simon Reilly Portfolio'
  end
end

