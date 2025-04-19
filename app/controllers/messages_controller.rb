# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_room

def create
  @message = @room.messages.build(message_params.merge(user: current_user))

  if @message.save
    Turbo::StreamsChannel.broadcast_append_to(
      "room_#{@room.id}_messages",
      target: "messages",
      partial: "messages/message",
      locals: { message: @message, current_user: current_user }
    )

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @room }
    end
  else
    # Error handling here
  end
end


  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end