class HomesController < ApplicationController
  def top
    @blog_ranks = Blog.find(Favorite.group(:blog_id).order('count(blog_id) desc').limit(9).pluck(:blog_id))
  end
end
