class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def show
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @videos = @category.videos.where(user: current_user).order(created_at: :desc)
    else
      @videos = current_user.videos.order(created_at: :desc)
    end
  end

 def index
  @videos = Video.includes(:category, :user).all
  @categories = Category.all
  @users = User.all
  
  # Add filtering logic if needed
  @videos = @videos.where(category_id: params[:category_id]) if params[:category_id].present?
  @videos = @videos.where(user_id: params[:user_id]) if params[:user_id].present?
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

  def edit; end

  def update
    if @video.update(video_params)
      redirect_to @video, notice: "Video updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  @video.files.each(&:purge_later) # this purges each file
  @video.destroy
  redirect_to videos_path, notice: 'Video was successfully deleted.'
end

def my
  @videos = current_user.videos.includes(:category)
end


# app/controllers/videos_controller.rb
def search
  @query = params[:query]
  @videos = Video.where("title ILIKE ?", "%#{@query}%")
  render :index  # Or render a dedicated search view if needed
end

  private

  def set_video
  @video = current_user.videos.find(params[:id])
rescue ActiveRecord::RecordNotFound
  redirect_to videos_path, alert: "Video not found."
end

def video_params
  params.require(:video).permit(:title, :description, :audience, :age_restriction, category_ids: [], files: []).tap do |whitelisted|
    whitelisted[:category_ids].reject!(&:blank?) if whitelisted[:category_ids]
    whitelisted[:files].reject!(&:blank?) if whitelisted[:files]
  end
end


end
