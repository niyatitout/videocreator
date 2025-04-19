class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    # Assign the user_id, either from session or by creating an anonymous user
    @message.user_id = session[:user_id] || create_anonymous_user&.id

    if @message.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      # Handle the failure (optional: add a flash message or redirect)
      redirect_to some_error_path, alert: "Message could not be saved"
    end
  end

  def message_params
    params.require(:message).permit(:content, :room_id)
  end

  private

  def create_anonymous_user
    random_id = SecureRandom.hex(4)
    begin
      user = User.create!(
        email: "new-email-#{random_id}@test.com"
      )
      session[:user_id] = user.id
      user
    rescue => e
      Rails.logger.error("Error creating anonymous user: #{e.message}")
      nil
    end
  end
end
