class CommentsController < ApplicationController
  before_action :authenticate_user!
def create
  @video = Video.find(params[:video_id]) # Make sure this exists in the form as hidden or nested

  @comment = @video.comments.build(comment_params.merge(user: current_user))

  if @comment.save
    flash[:notice] = "Comment added successfully!"
  else
    flash[:alert] = "Failed to add comment: #{@comment.errors.full_messages.to_sentence}"
  end

  redirect_back fallback_location: videos_path
end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
