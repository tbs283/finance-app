class BalancesController < ApplicationController
  def index
    @balance_new = Balance.new
    @balances = Balance.all
  end
  
  def show
    @balance = Balance.find(params[:id])
    @expense_new = @balance.expenses.new
    @expense_new = @balance.incomes.new
  end
  
  def create
    balanse_new = Balance.new(balance_params)
    balanse_new.save
    redirect_to user_balance_path(current_user, balanse_new.id)
  end
  
  private
  def balance_params
    params.require(:balance).permit(:user_id, :balance)
  end
end
