class ExpensesController < ApplicationController
  def create
    expense_new = Expense.new(expense_params)
    expense_new.save
    redirect_to user_balance_path(current_user, current_balance)
  end
  
  private
  def expense_params
    params.require(:expense).permit(:balance_id, :amount)
  end
end
