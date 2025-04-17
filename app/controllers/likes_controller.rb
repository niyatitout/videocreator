class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    likeable = find_likeable
    likeable.likes.create(user: current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def destroy
    likeable = find_likeable
    like = likeable.likes.find_by(user: current_user)
    like.destroy if like

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  private

  def find_likeable
    params[:likeable_type].constantize.find(params[:likeable_id])
  end
end
