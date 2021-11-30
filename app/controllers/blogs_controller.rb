class BlogsController < ApplicationController
  def show
    @blog = Blog.find(params[:id])
    @comment = Comment.new
  end

  def new
    @blog_new = Blog.new
  end
  
  def create
    @blog_new = Blog.new(blog_params)
    @blog_new.user_id = current_user.id
    if @blog_new.save
      redirect_to blog_path(@blog_new),notice:'投稿完了しました:)'
    else
      render :new,notice:'投稿に失敗しました:)'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blog_path(@blog)
    else
      render :edit
    end
  end
  
  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to blogs_path
  end
  
  def search
    @blogs = Blog.all.order(created_at: :desc).page(params[:page]).per(15)
    if params[:title].present?
      @blogs_search = Blog.where('title LIKE ?', "%#{params[:title]}%")
    else
      @blogs_search = Blog.none
    end
  end
  
  private
  def blog_params
    params.require(:blog).permit(:title, :content, :user_id)
  end
end
