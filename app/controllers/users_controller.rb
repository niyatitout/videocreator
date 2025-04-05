class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]

  def show
    @recent_videos = @user.videos.limit(5)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def dashboard
    @videos_count = current_user.videos.count
    @views_count = current_user.videos.sum(:views_count)
    @shares_count = current_user.videos.sum(:shares_count)
    @recent_videos = current_user.videos.limit(6)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless @user == current_user
      redirect_to root_path, alert: "You're not authorized to perform this action."
    end
  end

  def user_params
    params.require(:user).permit(:name, :title, :bio, :avatar)
  end
end