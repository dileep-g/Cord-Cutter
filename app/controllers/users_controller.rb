class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_channels, :set_devices, :set_boxes, only:[:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @user.antennas.each do |antenna|
      @channels << Channel.find(antenna.channel_id)
    end
    @user.own_devices.each do |own_device|
      @devices << Device.find(own_device.device_id)
    end
    @user.own_boxes.each do |own_box|
      @set_top_boxes << SetTopBox.find(own_box.set_top_box_id)
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      @user.update_attributes(admin: true) if params[:user][:admin] == '1'
      flash[:success] = "Sign up success!"
      redirect_to @user
    else
      render 'new'
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      if @user.update_columns(first_name: params[:user][:first_name], last_name: params[:user][:last_name])
        flash[:success] = "Update success"
         redirect_to @user
      else
         render 'edit'
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.id == current_user.id
      @user.destroy
      redirect_to root_path
    elsif @user.admin == true
      flash[:danger] = "You cannot delete an admin"
      redirect_to users_path
    else
      flash[:success] = "Delete success"
      @user.destroy
      redirect_to users_path
    end
  end

  def password
    @user = User.find(session[:user_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_channels
      @channels = Array.new
    end

    def set_devices
      @devices = Array.new
    end

    def set_boxes
      @set_top_boxes = Array.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_digest, :first_name, :last_name, :admin)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin_user
      unless admin?
        redirect_to root_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user || admin?
    end
end
