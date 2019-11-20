require 'webdrivers'
require 'watir'
require 'nokogiri'
require 'htmlentities'

desc "Playground to use watir to load web pages and extract channels"

task :load_page => :environment do
    
    # load all channels from database
    channels_in_db = []
    Channel.all.each do |channel|
        channels_in_db << channel.name.delete(' ').downcase
    end

    # load page
    browser = Watir::Browser.new :firefox, profile: 'default', headless: true
    # browser = Watir::Browser.new(:chrome, {:chromeOptions => {:args => ['--headless', '--window-size=1200x600']}})
    # browser.goto("https://try.philo.com/")
    browser.goto("https://www.hulu.com/live-tv")
    # browser.goto("https://tv.youtube.com/welcome/")
    # browser.goto("https://www.fubo.tv/welcome/channels")

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

        if channels_in_db.include?(alt) 
            puts "Class: %s, alt: %s" % [node['class'], node['alt']]
            html_channel_class = node['class']
            html_channel_attr = 'alt'
            break
        end

        if channels_in_db.include?(title)
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
            channels_in_page << node[html_channel_attr]
        end
    end

    puts channels_in_page

        
end