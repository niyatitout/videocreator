# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user


  private

def broadcast_message
  begin
    Turbo::StreamsChannel.broadcast_append_to(
      room,
      target: "messages",
      partial: "messages/message",
      locals: { message: self }
    )
  rescue => e
    Rails.logger.error "Failed to broadcast message: #{e.message}"
  end
end

end