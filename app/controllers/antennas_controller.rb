class AntennasController < ApplicationController
  before_action :logged_in_user, :correct_user

  def show
    @channels = Channel.order(:name)
    @user = User.find(params[:id])
    @antennas = Array.new
    @user.antennas.each do |antenna|
      @antennas << antenna.channel_id
    end
  end
  
  def update_antenna
    user = User.find(params[:id])
    Antenna.delete_record(params[:id])
    if params[:items] == nil
      redirect_to user
    else
      Antenna.create_record(params[:id], params[:items])
      redirect_to user
    end
  end
  
  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user || admin?
    end
end
