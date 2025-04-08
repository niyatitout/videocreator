class ChannelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel, only: [:show, :toggle_visibility]

  # GET /channels/new
  def new
    @channel = Channel.new # Initialize a new Channel instance
  end
  
  # POST /channels
  def create
    @channel = Channel.new(channel_params) # Create a new Channel instance
    @channel.user = current_user # Set the user to the current user
    if @channel.save
      redirect_to @channel, notice: "Channel created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def channel_params
    params.require(:channel).permit(:name, :description, :visibility) # Ensure :visibility is included
  end

  # GET /channels/:id
  def show
    # @channel is already set via before_action
  end

  # PATCH /channels/:id/toggle_visibility
  def toggle_visibility
    @channel.update!(is_public: !@channel.is_public)
    redirect_to @channel, notice: "Visibility updated!"
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end
end