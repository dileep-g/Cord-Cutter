class OwnDevicesController < ApplicationController
  before_action :logged_in_user, :correct_user


  def show
    @devices = Device.order(:name).all
    @user = User.find(params[:id])
    @own_devices = Array.new
    @user.own_devices.each do |own_device|
      @own_devices << own_device.device_id
    end
  end
  
  def update_own_device
    user = User.find(params[:id])
    OwnDevice.delete_record(params[:id])
    if params[:items] == nil
      redirect_to user
    else
      OwnDevice.create_record(params[:id], params[:items])
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
