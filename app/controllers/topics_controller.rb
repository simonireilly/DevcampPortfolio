class TopicsController < ApplicationController
  layout 'blog'
  before_action :set_topics
  def index
  end

  def show
    @topic = Topic.find(params[:id])
    if logged_in?(:site_admin)
        @blogs = @topic.blogs.page(params[:page]).per(5)
    else
      @blogs = @topic.blogs.published.page(params[:page]).per(5)
    end
  end

  private

  def set_topics
    @topics = Topic.with_blogs
  end
end
