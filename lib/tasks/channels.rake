require 'webdrivers'
require 'watir'

desc "Playground to use watir to load web pages and extract channels"

task :load_page do
    # browser = Watir::Browser.new :chrome, headless: true
    browser = Watir::Browser.new(:chrome, {:chromeOptions => {:args => ['--headless', '--window-size=1200x600']}})
    browser.goto("https://google.com")
    puts browser.title
end