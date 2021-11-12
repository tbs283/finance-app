class BudgetsController < ApplicationController
  before_action :budget_counter, only: [:new]
  
  def new
    @budget_new = Budget.new
  end
  
  def create
    @budget_new = Budget.new(budget_params)
    @budget_new.user_id = current_user.id
    if @budget_new.save
      redirect_to edit_budget_path(@budget_new)
    else
      render :new
    end
  end
  
  def edit
    @budget = Budget.find(params[:id])
  end
  
  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      redirect_to edit_budget_path(@budget)
    else
      render :edit
    end
  end
  
  private
  def budget_counter
    if current_user.budgets.count == 1
      redirect_to edit_budget_path(id:1) #Userがbudgetをちょうど一つ持っている時にeditに飛ばす
    end
  end
  
  def budget_params
    params.require(:budget).permit(:food, :house, :daily, :utility, :cloth, :hobby, :liberal_art, :communicate, :medical, :other)
  end
end
