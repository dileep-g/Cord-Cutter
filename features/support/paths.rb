module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'; home_path
    when /^the signin\s?page$/
      signin_path
    when /^the packages\s?page$/
      packages_path 
    when /^the channels\s?page$/
      channels_path
    when /^the channels1\s?page$/
      channel_path(1)
    when /^the user\s?page$/
      '/users/1'
    when /^the root\s?page$/
      root_path
    when /^the signup\s?page$/
      signup_path
    when /^the calculator\s?page$/
      '/calculator/1/input'
    when /^the calculator recommendation\s?page$/
      '/calculator/1/recommendation'  
    when /^the package\s?page$/
      package_path(1) 
    when /^the edit package\s?page$/
      edit_package_path(1) 
    when /^the new package\s?page$/
      new_package_path 
    when /^the devices\s?page$/
      devices_path 
    when /^the new device\s?page$/
      new_device_path 
    when /^the device\s?page$/
      device_path(1) 
    when /^the users\s?page$/
      users_path
    when /^the users1\s?page$/
      user_path(1)
    when /^the edit users1\s?page$/
      edit_users_path(1) 
    when /^the antenna\s?page$/
      antenna_path(1) 
    when /^the devices1\s?page$/
      own_device_path(1) 
    when /^the boxes1\s?page$/
      own_box_path(1) 
    when /^the edit channels\s?page$/
      edit_channel_path(1) 
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    
    when /^the edit page for "(.*)"$/i
      edit_stream_package_path(StreamPackage.find_by_name($1))
    
    when /^the details page for "(.*)"$/i
      stream_package_path(StreamPackage.find_by_name($1))

    when /^the channel details page for "(.*)"$/i
      channel_path(Channel.find_by_name($1))
      
    when /^the edit channel page for "(.*)"$/i
      edit_channel_path(Channel.find_by_name($1))
      
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
