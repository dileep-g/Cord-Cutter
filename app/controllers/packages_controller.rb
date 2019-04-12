class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy]
  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
    @channels = Channel.order(:name).all
    @packages = Array.new
    @package.provide_channels.each do |provide_channel|
      # @packages << provide_channel.channels.channel_id
      @packages << provide_channel.channel_id
    end
  end

  # GET /packages/new
  def new
    @package = Package.new
    
    @channels = Channel.order(:name).all
    @packages = Array.new
    @package.provide_channels.each do |provide_channel|
      # @packages << provide_channel.channels.channel_id
      @packages << provide_channel.channel_id
    end
  end

  # GET /packages/1/edit
  def edit
    @channels = Channel.order(:name).all
    @packages = Array.new
    @package.provide_channels.each do |provide_channel|
      # @packages << provide_channel.channels.channel_id
      @packages << provide_channel.channel_id
    end
  end

  # POST /packages
  # POST /packages.json
  def create
    # @channels = Channel.order(:name).all
    @package = Package.new(package_params)

      if @package.save
        current_package = Package.find_by(name: @package.name)
        ProvideChannel.create_record(current_package.id, params[:items])  
        flash[:success] = "Create success!"
        redirect_to @package
      else
        render 'new'
      end

  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    # package = Package.find(params[:id])
    ProvideChannel.delete_record(params[:id])
    # if params[:items] == nil
    #   redirect_to user
    # else
    #   ProvideChannel.create_record(params[:id], params[:items])
    #   redirect_to user
    # end 
    ProvideChannel.create_record(params[:id], params[:items])
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
    @package.destroy
    flash[:success] = "Delete success"
    redirect_to packages_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:name, :cost)
    end

    def admin_user
      unless admin?
        redirect_to root_path
      end
    end
end
