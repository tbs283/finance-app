class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end
  
  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog_new = Blog.new
  end
  
  def create
    blog_new = Blog.new(blog_params)
    blog_new.user_id = current_user.id
    blog_new.save
    redirect_to blog_path(blog_new.id)
  end

  def edit
  end
  
  private
  def blog_params
    params.require(:blog).permit(:title, :content, :user_id)
  end
end
