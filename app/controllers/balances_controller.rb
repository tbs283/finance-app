class BalancesController < ApplicationController
  def index
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @balance = current_user.balances
    @balance_new = Balance.new
    @balances = @balance.where(period: @month.all_month)#その月の収支
    @incomes = @balances.where(balance: 0, period: @month.all_month)#その月の収入
    @expenses = @balances.where(balance: 1, period: @month.all_month)#その月の支出
    @income_sum = @incomes.sum(:amount)#その月の収入の合計
    @expense_sum = @expenses.sum(:amount) #その月の支出の合計
    @balance_sum = @income_sum - @expense_sum #その月の収支
    @incomes_all = @balances.where(balance: 0)#すべての期間の収入
    @expenses_all = @balances.where(balance: 1)#すべての期間の支出全体
    @income_all_sum = @incomes_all.sum(:amount)#収入全体の合計
    @expense_all_sum = @expenses_all.sum(:amount)#支出全体の合計
    @saving = @income_all_sum-@expense_all_sum#貯金額
  end

  def register
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
  end

  def expense
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
  end

  def new
    @balance_new = Balance.new
  end

  def show
    @balance = Balance.find(params[:id])
  end

  def create
    @balance_new = Balance.new(
      balance: balance_params[:balance].to_i,
      genre: balance_params[:genre].to_i,
      amount: balance_params[:amount],
      period: balance_params[:period],
      description: balance_params[:description]
      )
    @balance_new.user_id = current_user.id
    if @balance_new.save
      redirect_to balances_path
    else
      @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
      @balances = current_user.balances
      @incomes = @balances.where(balance: 0, period: @month.all_month)
      @expenses = @balances.where(balance: 1, period: @month.all_month)
      @income_sum = @incomes.sum(:amount)
      @expense_sum = @expenses.sum(:amount)
      @saving = @income_sum-@expense_sum
      render :register
    end
  end

  def update
    @balance = Balance.find(params[:id])
    if @balance.update(balance_params)
      redirect_to balance_path(@balance)
    else
      render :show
    end
  end

  def destroy
    balance = Balance.find(params[:id])
    balance.destroy
    redirect_to balances_path
  end

  private
  def balance_params
    params.require(:balance).permit(:user_id, :balance, :period, :genre, :amount, :description)
  end
end
