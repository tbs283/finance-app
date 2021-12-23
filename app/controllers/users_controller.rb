class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_release = User.select('release').find_by(release: "true")
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @balance = @user.balances
    @balances = @balance.where(period: @month.all_month)#その月の収支
    @incomes = @balances.where(balance: 0, period: @month.all_month)#その月の収入
    @expenses = @balances.where(balance: 1, period: @month.all_month)#その月の支出
    @income_sum = @incomes.sum(:amount)#その月の収入の合計
    @expense_sum = @expenses.sum(:amount) #その月の支出の合計
    @balance_sum = @income_sum - @expense_sum #その月の収支
    
    #予算
    @budget = Budget.where(user_id: @user.id).last
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
    if @budget.present?
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

  def search
    @search_params = user_search_params  #検索結果の画面で、フォームに検索した値を表示するために、paramsの値をビューで使えるようにする
    @users = User.search(@search_params) #Reservationモデルのsearchを呼び出し、引数としてparamsを渡している。
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
  def user_search_params
    params.fetch(:search, {}).permit(:name, :sex, :age, :region)
    #fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
    #ここでの:searchには、フォームから送られてくるparamsの値が入っている
  end
end