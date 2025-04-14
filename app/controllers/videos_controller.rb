class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    @videos = current_user.videos.order(created_at: :desc)
  end

  def show
  end

  def new
    @video = current_user.videos.new
  end

 def create
  @video = current_user.videos.new(video_params)
  
  if @video.save
    redirect_to videos_path, notice: "Video uploaded successfully."
  else
    render :new, status: :unprocessable_entity
  end
end


  def edit
  end

  def update
    if @video.update(video_params)
      redirect_to @video, notice: "Video updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @video.destroy
    redirect_to videos_path, notice: "Video deleted successfully."
  end

  private

  def set_video
    @video = current_user.videos.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :description, :audience, :age_restriction, :scheduled_at, files: [])
  end
end
