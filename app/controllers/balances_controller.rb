class BalancesController < ApplicationController
  def index
    @balances = current_user.balances
    @balance_new = Balance.new
    @incomes = @balances.where(balance: 0)
    @expenses = @balances.where(balance: 1)
    @income_sum = @incomes.sum(:amount)
    @expense_sum = @expenses.sum(:amount)
    @saving = @income_sum-@expense_sum
  end
  
  def new
    @balance_new = Balance.new
  end
  
  def show
    @balance = Balance.find(params[:id])
  end
  
  def create
    @balance_new = Balance.new(
      # period: balance_params[:period],
      balance: balance_params[:balance].to_i,
      amount: balance_params[:amount],
      period: balance_params[:period],
      description: balance_params[:description]
      )
    @balance_new.user_id = current_user.id
    if @balance_new.save
      redirect_to balances_path
    else
      @balances = current_user.balances
      @incomes = @balances.where(balance: 0)
      @expenses = @balances.where(balance: 1)
      @income_sum = @incomes.sum(:amount)
      @expense_sum = @expenses.sum(:amount)
      @saving = @income_sum-@expense_sum
      render :index
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
    params.require(:balance).permit(:user_id, :balance, :period, :expense_genre_id, :income_genre_id, :amount, :description)
  end
end
