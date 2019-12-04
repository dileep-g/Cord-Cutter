require 'webdrivers'
require 'watir'
require 'nokogiri'
require 'htmlentities'

class PackagesController < ApplicationController

  before_action :set_package, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy, :select_origin, :new_hierarchical]
  before_action :find_information, only: [:show, :new, :edit, :create, :update, :new_hierarchical, :parse_channels]
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
      ProvideChannel.create_record(params[:id], params[:channels])  
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

  def parse_channels
    @package = Package.new
    @package.name = params['name'] || cookies['package_name']
    @package.cost = params['cost'] || cookies['package_cost']
    @package.link = params['link'] || cookies['package_link']

    if !@package.link? or @package.link.to_s.strip.empty?
      render 'new'
      return
    end

    # MOVE TO SEPARATE MODULE
    # load all channels from database
    all_channels = []
    Channel.all.each do |channel|
        all_channels << channel.name.delete(' ').downcase
    end

    browser = nil
    # load page
    if Rails.env.production?
      Selenium::WebDriver::Chrome.path = "/app/.apt/usr/bin/google-chrome"
      Selenium::WebDriver::Chrome.driver_path = "/app/.chromedriver/bin/chromedriver"
      browser = Watir::Browser.new :chrome
    else
      browser = Watir::Browser.new :firefox, profile: 'default', headless: true
    end
    # browser = Watir::Browser.new(:chrome, {:chromeOptions => {:args => ['--headless', '--window-size=1200x600']}})
    # browser.goto("https://try.philo.com/")
    # browser.goto("https://www.hulu.com/live-tv")
    # browser.goto("https://tv.youtube.com/welcome/")
    # browser.goto("https://www.fubo.tv/welcome/channels")
    browser.goto(@package.link)

    sleep 1
    puts "Page loaded: %s" % browser.title
    
    document = Nokogiri::HTML(browser.body.html)
    html_coder = HTMLEntities.new
    html_channel_class = ""
    html_channel_attr = ""
    document.traverse do |node|
        next unless node.is_a?(Nokogiri::XML::Element)
        
        alt = html_coder.decode(node['alt']).delete(' ').downcase
        title = html_coder.decode(node['title']).delete(' ').downcase

        if all_channels.include?(alt) 
            puts "Class: %s, alt: %s" % [node['class'], node['alt']]
            html_channel_class = node['class']
            html_channel_attr = 'alt'
            break
        end

        if all_channels.include?(title)
            puts "Class: %s, title: %s" % [node['class'], node['title']]
            html_channel_class = node['class']
            html_channel_attr = 'title' 
            break
        end
    end

    # extract elements with class == <html_channel_class>
    channels_in_page = []
    document.traverse do |node|
        next unless node.is_a?(Nokogiri::XML::Element)
        
        if node['class'] == html_channel_class
            channels_in_page << html_coder.decode(node[html_channel_attr])
        end
    end

    puts "Channels found on page: %s" % [channels_in_page]
    
    # Channels from DB
    @channels = Channel.order(:name)
    channel_objs = {}
    @channels.each do |channel_obj|
      channel_objs[channel_obj.name.delete(' ').downcase] = channel_obj
    end

    channels_in_db = Array.new
    channels_not_in_db = Array.new
    @package_channels = Array.new
    channels_in_page.each do |channel|
      if channel_objs.key?(channel.delete(' ').downcase)
        @package_channels << channel_objs[channel.delete(' ').downcase]
        channels_in_db << channel
      else 
        channels_not_in_db << channel
      end    
    end

    puts "channels in DB && page" % @package_channels.length
    i = 0
    @package_channels.each do |channel|
      unless channel.nil?
        print "%s, " % channel.name
        i += 1
      end
    end
    puts "#%d" % [i]

    puts "setting cookies"
    cookies[:package_name] = {:value => @package.name, :expires => 1.hour.from_now}
    cookies[:package_cost] = {:value => @package.cost, :expires => 1.hour.from_now}
    cookies[:package_link] = {:value => @package.link, :expires => 1.hour.from_now}

    if channels_in_db.length() > 0
      cookies[:channels_in_db] = {:value => channels_in_db.join(","), :expires => 1.hour.from_now}
    end
    
    if channels_not_in_db.length() > 0
      cookies[:channels_not_in_db] = {:value => channels_not_in_db.join(","), :expires => 1.hour.from_now}
      @count_not_in_db = channels_not_in_db.length().to_s
    end
    
    render 'new'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      if Package.where(id: params[:id]).blank?
        redirect_to home_path
      else
        @package = Package.find(params[:id])
      end
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
