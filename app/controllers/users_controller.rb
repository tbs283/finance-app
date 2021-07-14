class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def mypage
    @user = current_user
    @last_goal = Goal.where(user_id: current_user.id).last
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
  
  private
  def user_params
    params.require(:user).permit(:email, :name, :goal, :goal_limit, :image)
  end
end
