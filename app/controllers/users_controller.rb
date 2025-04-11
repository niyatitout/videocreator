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
  @user = current_user

  if @user.update(user_params)
    redirect_to @user, notice: "Profile updated successfully."
  else
    render :edit, status: :unprocessable_entity
  end
end



  def dashboard
    @videos_count = current_user.videos.count
    @views_count = current_user.videos.sum(:views_count)
    @shares_count = current_user.videos.sum(:shares_count)
    @recent_videos = current_user.videos.limit(6)
  end
  

  def destroy
    @user = User.find(params[:id])
    @user.discard
    redirect_to root_path, notice: "Account successfully deleted (soft)."
  end
  


 def set_user
   @user = User.find_by(id: params[:id]) # Using find_by instead of find
   if @user.nil?
    redirect_to root_path, alert: "User not found."
  end
 end


  def authorize_user
    unless @user == current_user
      redirect_to root_path, alert: "You're not authorized to perform this action."
    end
  end

  def user_params
  params.require(:user).permit(:name, :email, :avatar, :title, :bio, :pronouns, :account_type)
end


#2fa

  def security_settings
    @user = current_user
  end


end