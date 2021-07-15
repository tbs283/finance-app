class GoalsController < ApplicationController
  def new
    @goal_new = Goal.new
  end
  
  def create
    @goal_new = Goal.new(
      goal_amount: goal_params[:goal_amount]
      )
    @goal_new.user_id = current_user.id
    if @goal_new.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def goalselect
  end
  
  def edit
    @last_goal = Goal.find(params[:id])
  end
  
  def update
    goal = Goal.find(params[:id])
    if goal.update(goal_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end
  
  def remove
    goal = Goal.all
    goal.destroy_all
    redirect_to root_path
  end
  
  private
  def goal_params
    params.require(:goal).permit(:user_id, :goal_amount, :goal_limit)
  end
end
