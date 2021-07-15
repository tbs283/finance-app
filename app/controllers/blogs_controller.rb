class BlogsController < ApplicationController
  def index
    @blogs = Blog.all.order(created_at: :desc)
  end
  
  def show
    @blog = Blog.find(params[:id])
    @comment = Comment.new
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
    @blog = Blog.find(params[:id])
  end
  
  def update
    blog = Blog.find(params[:id])
    blog.update(blog_params)
    redirect_to blog_path(blog)
  end
  
  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to blogs_path
  end
  
  private
  def blog_params
    params.require(:blog).permit(:title, :content, :user_id)
  end
end
