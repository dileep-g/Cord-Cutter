class UsersController < ApplicationController
  include UsersHelper
  
  before_action :set_user, only: [:show, :edit, :update, :destroy, :calculator, :calculate, :change_password, :update_password]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy, :calculator, :change_password, :update_password]
  before_action :admin_user, only: [:index]
  before_action :correct_user, only: [:show, :edit, :update, :destroy, :calculator, :change_password, :update_password]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
      @user = User.find(params[:id])
      @channels = Array.new
      @user.antennas.each do |antenna|
        @channels << Channel.find(antenna.channel_id)
     end
      @channels.sort_by{|e| e[:name]}
      @devices = Array.new
      @user.own_devices.each do |own_device|
        @devices << Device.find(own_device.device_id)
      end
      @devices.sort_by{|e| e[:name]}
      @set_top_boxes = Array.new
      @user.own_boxes.each do |own_box|
        @set_top_boxes << SetTopBox.find(own_box.set_top_box_id)
      end
      @set_top_boxes.sort_by{|e| e[:name]}
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
    if @user.admin == true
      flash[:danger] = "You cannot delete an admin"
      redirect_to users_path
    else
      flash[:success] = "Delete success"
      Antenna.where(user_id: @user.id).delete_all
      OwnBox.where(user_id: @user.id).delete_all
      OwnDevice.where(user_id: @user.id).delete_all
      @user.destroy
      redirect_to users_path
    end
  end

  def calculator
    @channels = Channel.order(:name)
    @user = User.find(params[:id])
    @must_have = Array.new
    @would_have = Array.new
    @ok_have = Array.new
    @user.perferences.each do |perference|
      if perference.rate == 3
        @must_have << perference.channel.id
      elsif perference.rate == 2
        @would_have << perference.channel.id
      elsif perference.rate == 1
        @ok_have << perference.channel.id
      end
    end
    @budget = 0.0
    @flag_dvr = false
  end
  
  def result 
    @results_overall = get_result(params[:id], params[:flag_one_pack], params[:budget], params[:flag_dvr])
    @covered_antenna = Antenna.covered_channels(params[:id])
  end 
  
  def calculate
    @channels = Channel.order(:name)
    Perference.delete_record(params[:id])
    Perference.create_record(params[:id], params[:must_have], params[:would_have], params[:ok_have])
    must_have = Antenna.remove_channel(params[:id], params[:must_have])
    would_have = Antenna.remove_channel(params[:id], params[:would_have])
    ok_have = Antenna.remove_channel(params[:id], params[:ok_have])
    must_have, would_have, ok_have = Perference.remove_redudant(must_have, would_have, ok_have)
    if params[:budget] == ''
      params[:budget] = 9999
    else
      params[:budget] = params[:budget].to_f
    end

    if params[:flag_one_pack] == nil
      params[:flag_one_pack] = 'false'
    end
    
    if params[:flag_dvr] == nil
      params[:flag_dvr] = 'false'
    end

    redirect_to result_path(params[:id], params[:flag_one_pack], params[:flag_dvr], params[:budget])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if User.where(id: params[:id]).blank?
        redirect_to home_path
      else
        @user = User.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_digest, :first_name, :last_name, :admin, :results, :result)
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
