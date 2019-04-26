class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy]

  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)

      if @channel.save
        flash[:success] = "Create success!"
        redirect_to @channel
      else
        render 'new'
      end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
      if @channel.update(channel_params)
        flash[:success] = "Update success!"
        redirect_to @channel
      else
        render 'edit'
      end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    Antenna.where(channel_id: @channel.id).delete_all
    ProvideChannel.where(channel_id: @channel.id).delete_all
    Perference.where(channel_id: @channel.id).delete_all
    @channel.destroy
    flash[:success] = "Delete success"
    redirect_to channels_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      if Channel.where(id: params[:id]).blank?
        redirect_to home_path
      else
        @channel = Channel.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:name)
    end

    def admin_user
      unless admin?
        redirect_to root_path
      end
    end
end
