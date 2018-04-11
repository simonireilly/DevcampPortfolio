class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :update, :destroy, :toggle_status]
  before_action :set_topics
  layout 'blog'
  access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit, :toggle_status]}, site_admin: :all

  def index
    if logged_in?(:site_admin)
      @blogs = Blog.page(params[:page]).per(5)
    else
      @blogs = Blog.published.page(params[:page]).per(5)
    end
  end

  def show
    if logged_in?(:site_admin) || @blog.published?
    @blog = Blog.includes(:comments).friendly.find(params[:id])
    @comment = Comment.new

    @page_title = @blog.title
    @seo_keywords = @blog.body
    else
      redirect_to blogs_path, notice: 'You do not have access to that page'
    end
  end

  def new
    @blog = Blog.new
    @blog.build_topic
  end

  def edit
    @blog = Blog.includes(:topic).friendly.find(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)
    @topic = Topic.find_by(title: blog_params[:topic_attributes][:title])
    @blog.topic_id = @topic.id unless @topic.nil?

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    update_topic_id
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
    end
  end

  def toggle_status
    (@blog.published? ? @blog.draft! : @blog.published!)
    redirect_to blogs_url, notice: 'Blog status updated'
  end

  private
  def set_blog
    @blog = Blog.friendly.find(params[:id])
  end

  def set_topics
    @topics = Topic.all
  end

  def blog_params
    params.require(:blog).permit(:title, :body, :status, topic_attributes: [:title, :id])
  end

  def update_topic_id
    # Topic can exist, so we need to change the foreign key, not update its attributes
    @topic = Topic.find_by(title: blog_params[:topic_attributes][:title]) || Topic.new
    params[:blog][:topic_attributes][:id] = @topic.id unless @topic.nil?
    @blog.topic_id = @topic.id unless @topic.nil?
  end
end
