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

      @budget = current_user.budgets
      @food = @balances.where(genre: 1, period: @month.all_month).sum(:amount)
      @house = @balances.where(genre: 2, period: @month.all_month).sum(:amount)
      @daily = @balances.where(genre: 3, period: @month.all_month).sum(:amount)
      @utility = @balances.where(genre: 4, period: @month.all_month).sum(:amount)
      @cloth = @balances.where(genre: 5, period: @month.all_month).sum(:amount)
      @hobby = @balances.where(genre: 6, period: @month.all_month).sum(:amount)
      @liberal_art = @balances.where(genre: 7, period: @month.all_month).sum(:amount)
      @communicate = @balances.where(genre: 8, period: @month.all_month).sum(:amount)
      @medical = @balances.where(genre: 9, period: @month.all_month).sum(:amount)
      @other = @balances.where(genre: 10, period: @month.all_month).sum(:amount)
    else
    end
  end

end
