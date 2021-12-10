class ReportsController < ApplicationController
  def yearbalance
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @year = params[:year] ? Date.parse(params[:year]) : Time.zone.today
    @balances = current_user.balances
    @incomes = @balances.where(balance: 0, period: @month.all_month)#その月の収入
    @expenses = @balances.where(balance: 1, period: @month.all_month)#その月の支出
    @income_sum = @incomes.sum(:amount)#その月の収入の合計
    @expense_sum = @expenses.sum(:amount) #その月の支出の合計
    @balance = @income_sum #その月の収支
  end
  
  def yeargenre
    @year = params[:year] ? Date.parse(params[:year]) : Time.zone.today
    @balances = current_user.balances
    @incomes = @balances.where(balance: 0, period: @year.all_year)
    @expenses = @balances.where(balance: 1, period: @year.all_year)
  end
  
  def totalsaving
    @balances = current_user.balances
    @incomes_all = @balances.where(balance: 0)#収入全体
    @expenses_all = @balances.where(balance: 1)#支出全体
    @income_all_sum = @incomes_all.sum(:amount)#収入全体の合計
    @expense_all_sum = @expenses_all.sum(:amount)#支出全体の合計
    @saving = @income_all_sum-@expense_all_sum#貯金額
  end
end
