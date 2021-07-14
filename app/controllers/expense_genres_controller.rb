class ExpenseGenresController < ApplicationController
  def new
    @expense_genre_new = ExpenseGenre.new
  end
  
  def create
    expense_genre_new = ExpenseGenre.new(expense_genre_params)
    expense_genre_new.save
    redirect_to redirect_to user_balances_path(current_user)
  end
  
  private
  def expense_genre_params
    params.require(:expense_genre).permit(:name, :balance_id)
  end
end
