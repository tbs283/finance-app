class HomesController < ApplicationController
  def top
    @blog_ranks = Blog.find(Favorite.group(:blog_id).order('count(blog_id) desc').limit(9).pluck(:blog_id))
    @new_blog = Blog.all.order(created_at: :desc)
    if user_signed_in?
      @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
      @balances = current_user.balances
      @balance_new = Balance.new
      @incomes = @balances.where(balance: 0, period: @month.all_month)#その月の収入
      @expenses = @balances.where(balance: 1, period: @month.all_month)#その月の支出
      @income_sum = @incomes.sum(:amount)#その月の収入の合計
      @expense_sum = @expenses.sum(:amount) #その月の支出の合計
      @balance = @income_sum-@expense_sum #その月の収支
      @incomes_all = @balances.where(balance: 0)#収入全体
      @expenses_all = @balances.where(balance: 1)#支出全体
      @income_all_sum = @incomes_all.sum(:amount)#収入全体の合計
      @expense_all_sum = @expenses_all.sum(:amount)#支出全体の合計
      @saving = @income_all_sum-@expense_all_sum#貯金額
    else
    end
  end
  
end
