class BudgetsController < ApplicationController
  before_action :budget_counter, only: [:new]

  def index
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @budget = Budget.find_by(user_id: current_user.id)
    @expenses = current_user.balances.where(balance: 1, period: @month.all_month)#その月の支出

    @food = @expenses.where(genre: 1, period: @month.all_month).sum(:amount)
    @house = @expenses.where(genre: 2, period: @month.all_month).sum(:amount)
    @daily = @expenses.where(genre: 3, period: @month.all_month).sum(:amount)
    @utility = @expenses.where(genre: 4, period: @month.all_month).sum(:amount)
    @cloth = @expenses.where(genre: 5, period: @month.all_month).sum(:amount)
    @hobby = @expenses.where(genre: 6, period: @month.all_month).sum(:amount)
    @liberal_art = @expenses.where(genre: 7, period: @month.all_month).sum(:amount)
    @communicate = @expenses.where(genre: 8, period: @month.all_month).sum(:amount)
    @medical = @expenses.where(genre: 9, period: @month.all_month).sum(:amount)
    @other = @expenses.where(genre: 10, period: @month.all_month).sum(:amount)
  end

  def new
    @budget_new = Budget.new
  end

  def create
    @budget_new = Budget.new(budget_params)
    @budget_new.user_id = current_user.id
    if @budget_new.save
      redirect_to budgets_path
    else
      render :new
    end
  end

  def destroy
    budget = Budget.find_by(user_id: current_user.id)
    budget.destroy
    redirect_to new_budget_path
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
