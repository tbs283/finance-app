class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @userb = User.select('release').find_by(release: "true")
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @balance = @user.balances
    @balances = @balance.where(period: @month.all_month)#その月の収支
    @incomes = @balances.where(balance: 0, period: @month.all_month)#その月の収入
    @expenses = @balances.where(balance: 1, period: @month.all_month)#その月の支出
    @income_sum = @incomes.sum(:amount)#その月の収入の合計
    @expense_sum = @expenses.sum(:amount) #その月の支出の合計
    @balance_sum = @income_sum - @expense_sum #その月の収支
  end

  def mypage
    @user = current_user
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @balance = current_user.balances
    @balances = @balance.where(period: @month.all_month)#その月の収支
    @incomes = @balances.where(balance: 0, period: @month.all_month)#その月の収入
    @expenses = @balances.where(balance: 1, period: @month.all_month)#その月の支出
    @income_sum = @incomes.sum(:amount)#その月の収入の合計
    @expense_sum = @expenses.sum(:amount) #その月の支出の合計
    @balance_sum = @income_sum - @expense_sum #その月の収支
    
    @incomes_all = @balance.where(balance: 0)#収入全体
    @expenses_all = @balance.where(balance: 1)#支出全体
    @income_all_sum = @incomes_all.sum(:amount)#収入全体の合計
    @expense_all_sum = @expenses_all.sum(:amount)#支出全体の合計
    @saving = @income_all_sum-@expense_all_sum#貯金額
  end

  def create
    user_new = User.new(user_params)
    user_new.save
    redirect_to root_path
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to mypage_path
  end
  
  def following
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    #@userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :image, :introduction, :release, :sex, :region, :age)
  end
end