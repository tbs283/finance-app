class HomesController < ApplicationController
  def top
    @blog_ranks = Blog.find(Favorite.group(:blog_id).order('count(blog_id) desc').limit(9).pluck(:blog_id))
    @new_blog = Blog.all.order(created_at: :desc)
    if user_signed_in? && Goal.exists?
      @last_goal = Goal.where(user_id: current_user.id).last
      # @days_left = (@last_goal.goal_limit - Date.current-1).to_i
      @incomes = current_user.balances.where(balance: 0).sum(:amount)
      @expenses = current_user.balances.where(balance: 1).sum(:amount)
      @savings = @incomes - @expenses
      if @last_goal.goal_amount - @savings.to_i < 0
        redirect_to goals_select_path
      else
        @to_goal = @last_goal.goal_amount - @savings.to_i
      end
      @to_goal = @last_goal.goal_amount.to_i - @savings.to_i
    elsif user_signed_in?
      @incomes = current_user.balances.where(balance: 0).sum(:amount)
      @expenses = current_user.balances.where(balance: 1).sum(:amount)
      @savings = @incomes - @expenses
    else
    end
  end
  
end
