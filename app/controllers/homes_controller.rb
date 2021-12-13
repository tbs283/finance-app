class HomesController < ApplicationController
  def top
    @blog_ranks = Blog.find(Favorite.group(:blog_id).order('count(blog_id) desc').limit(9).pluck(:blog_id))
    @new_blog = Blog.all.order(created_at: :desc)
    if user_signed_in?
      @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
      @balances = current_user.balances
      @balance_new = Balance.new
      @incomes = @balances.where(balance: 0, period: @month.all_month)#その月の収入
      @expenses = @balances.where(balance: 1, period: @month.all_month)#その月の支出
      @income_sum = @incomes.sum(:amount)#その月の収入の合計
      @expense_sum = @expenses.sum(:amount) #その月の支出の合計
      @balance = @income_sum-@expense_sum #その月の収支
      @incomes_all = @balances.where(balance: 0)#収入全体
      @expenses_all = @balances.where(balance: 1)#支出全体
      @income_all_sum = @incomes_all.sum(:amount)#収入全体の合計
      @expense_all_sum = @expenses_all.sum(:amount)#支出全体の合計
      @saving = @income_all_sum-@expense_all_sum#貯金額

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
    else
    end
  end

end
