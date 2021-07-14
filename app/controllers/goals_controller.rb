class GoalsController < ApplicationController
  def new
    @goal_new = Goal.new
  end
  
  def create
    goal_new = User.new(goal_params)
    goal_new.save
    redirect_to root_path
  end
  
  def edit
    @goal = current_user.goal
  end
  
  def update
    goal = current_user.goal
    goal.update(goal_params)
    redirect_to mypage_path
  end
  
  private
  def goal_params
    params.require(:goal).permit(:user_id, :goal_amount, :goal_limit)
  end
end
