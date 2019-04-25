class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy, :select_origin, :new_hierarchical]
  before_action :find_information, only: [:show, :new, :edit, :create, :update, :new_hierarchical]
  before_action :find_relationship, only: [:show, :edit, :update, :new_hierarchical]
  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # GET /packages/new
  def new
    @package = Package.new
  end

  # GET /packages/1/edit
  def edit
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)

      if @package.save
        current_package = Package.find_by(name: @package.name)
        if params[:devices] != nil
          SupportDevice.create_record(current_package.id, params[:devices])
        end
        if params[:channels] != nil
          ProvideChannel.create_record(current_package.id, params[:channels])  
        end
        if params[:set_top_boxes] != nil
          SupportBox.create_record(current_package.id, params[:set_top_boxes])
        end
        flash[:success] = "Create success!"
        redirect_to @package
      else
        render 'new'
      end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    ProvideChannel.delete_record(params[:id])
    SupportDevice.delete_record(params[:id])
    SupportBox.delete_record(params[:id])
    if params[:devices] != nil
      SupportDevice.create_record(params[:id], params[:devices])
    end
    if params[:channels] != nil
      # ProvideChannel.create_record(params[:id], params[:channels])  
    end
    if params[:set_top_boxes] != nil
      SupportBox.create_record(params[:id], params[:set_top_boxes])
    end
    if @package.update(package_params)
      flash[:success] = "Update success!"
      redirect_to @package
    else
      render 'edit'
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    ProvideChannel.delete_record(params[:id])
    SupportDevice.delete_record(params[:id])
    SupportBox.delete_record(params[:id])
    @package.destroy
    flash[:success] = "Delete success"
    redirect_to packages_path
  end

  def select_origin
    @packages = Package.order(:name).paginate(page: params[:page], per_page: 10)
  end

  def new_hierarchical
    @package = Package.new
    origin_package = Package.find(params[:id])
    @package.name = origin_package.name
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    def find_relationship
      package = Package.find(params[:id])
      @package_channels = Array.new
      package.provide_channels.each do |provide_channel|
        @package_channels << Channel.find(provide_channel.channel_id)
      end
      @package_devices = Array.new
      package.support_devices.each do |support_device|
        @package_devices << Device.find(support_device.device_id)
      end
      @package_boxes = Array.new
      package.support_boxes.each do |support_box|
        @package_boxes << SetTopBox.find(support_box.set_top_box_id)
      end
    end

    def find_information
      @channels = Channel.order(:name)
      @devices = Device.order(:name)
      @boxes = SetTopBox.order(:name)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:name, :cost, :link, :DVR)
    end

    def admin_user
      unless admin?
        redirect_to root_path
      end
    end

end
