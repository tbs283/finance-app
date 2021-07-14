class IncomeGenresController < ApplicationController
  def new
    @income_genre_new = IncomeGenre.new
  end
  
  def create
    income_genre_new = IncomeGenre.new(income_genre_params)
    income_genre_new.save
    redirect_to redirect_to user_balances_path(current_user)
  end
  
  private
  def income_genre_params
    params.require(:income_genre).permit(:name, :balance_id)
  end
end