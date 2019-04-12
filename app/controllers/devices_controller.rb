class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    @packages = Package.order(:name).all
    @devices = Array.new
    @device.support_devices.each do |support_device|
      @devices << support_device.package_id
    end
  end

  # GET /devices/new
  def new
    @device = Device.new
    @packages = Package.order(:name).all
    @devices = Array.new
    @device.support_devices.each do |support_device|
      @devices << support_device.package_id
    end
  end

  # GET /devices/1/edit
  def edit
    @packages = Package.order(:name).all
    @devices = Array.new
    @device.support_devices.each do |support_device|
      @devices << support_device.package_id
    end
  end

  # POST /devices
  # POST /devices.json
  def create
    @packages = Package.order(:name).all
    @device = Device.new(device_params)

      if @device.save
        current_device = Device.find_by(name: @device.name)
        SupportDevice.create_record(current_device.id, params[:items]) 
        flash[:success] = "Create success!"
        redirect_to @device
      else
        render 'new'
       
      end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    SupportDevice.delete_record(params[:id])
    SupportDevice.create_record(params[:id], params[:items])
      if @device.update(device_params)
        flash[:success] = "Update success!"
        redirect_to @device
      else
        render 'edit'
      end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    flash[:success] = "Delete success"
    redirect_to devices_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:name)
    end

    def admin_user
      unless admin?
        redirect_to root_path
      end
    end
end
