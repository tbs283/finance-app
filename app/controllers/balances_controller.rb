class BalancesController < ApplicationController
  def index
    @balances = Balance.all
    @balance_new = Balance.new
    @incomes = Balance.where(balance: 0)
    @expenses = Balance.where(balance: 1)
    @income_sum = @incomes.sum(:amount)
    @expense_sum = @expenses.sum(:amount)
  end
  
  def new
    @balance_new = Balance.new
  end
  
  def show
    @balance = Balance.find(params[:id])
  end
  
  def create
    balanse_new = Balance.new(
      period: balance_params[:period],
      balance: balance_params[:balance].to_i,
      amount: balance_params[:amount]
      )
    balanse_new.save
    redirect_to user_balances_path(current_user)
  end
  
  private
  def balance_params
    params.require(:balance).permit(:user_id, :balance, :period, :expense_genre_id, :income_genre_id, :amount)
  end
end
