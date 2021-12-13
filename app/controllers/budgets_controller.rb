class BudgetsController < ApplicationController
  def index
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @balances = current_user.balances
    @expenses = @balances.where(balance: 1, period: @month.all_month)#その月の支出
    @expense_sum = @expenses.sum(:amount) #その月の支出の合計

    @budget = Budget.where(user_id: current_user.id).last
    @food = @expenses.where(genre: 1, period: @month.all_month).sum(:amount) #当月の食費
    @house = @expenses.where(genre: 2, period: @month.all_month).sum(:amount) #当月の住居費
    @daily = @expenses.where(genre: 3, period: @month.all_month).sum(:amount) #当月の日用品
    @utility = @expenses.where(genre: 4, period: @month.all_month).sum(:amount) #当月の水道光熱費
    @cloth = @expenses.where(genre: 5, period: @month.all_month).sum(:amount) #当月の衣類
    @hobby = @expenses.where(genre: 6, period: @month.all_month).sum(:amount) #当月の趣味娯楽費
    @liberal_art = @expenses.where(genre: 7, period: @month.all_month).sum(:amount) #当月の教養
    @communicate = @expenses.where(genre: 8, period: @month.all_month).sum(:amount) #当月の通信費
    @medical = @expenses.where(genre: 9, period: @month.all_month).sum(:amount) #当月の医療費
    @other = @expenses.where(genre: 16, period: @month.all_month).sum(:amount) #当月のその他費用
    #予算と支出の差額
    @bfood = @budget.food-@food
    @bhouse = @budget.house-@house
    @bdaily = @budget.daily-@daily
    @butility = @budget.utility-@utility
    @bcloth= @budget.cloth-@cloth
    @bhobby= @budget.hobby-@hobby
    @bliberal_art = @budget.liberal_art-@liberal_art
    @bcommunicate= @budget.communicate-@communicate
    @bmedical = @budget.medical-@medical
    @bother = @budget.other-@other
    @foodper = @food.to_f/@budget.food*100
    @houseper = @house.to_f/@budget.house*100
    @dailyper = @daily.to_f/@budget.daily*100
    @utilityper = @utility.to_f/@budget.utility*100
    @clothper = @cloth.to_f/@budget.cloth*100
    @hobbyper = @hobby.to_f/@budget.hobby*100
    @liberal_artper = @liberal_art.to_f/@budget.liberal_art*100
    @communicateper = @communicate.to_f/@budget.communicate*100
    @medicalper = @medical.to_f/@budget.medical*100
    @otherper = @other.to_f/@budget.other*100
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
  def budget_params
    params.require(:budget).permit(:food, :house, :daily, :utility, :cloth, :hobby, :liberal_art, :communicate, :medical, :other)
  end
end