Given(/^the following packages exist:$/) do |packages_table|
  packages_table.hashes.each do |package_hash|
    if package_hash["channels"]
      stream_package = Package.new
      stream_package.name = package_hash["name"]
      stream_package.cost = package_hash["cost"]
      channels_string = package_hash["channels"]
      channels_list = channels_string.split(',')
      channels_list.each do |channel_name|
        channel = Channel.find_by(name: channel_name)
        stream_package.channels << channel if channel
      end
      stream_package.save
    else
      Package.create package_hash
    end
  end
end

Given(/^the following channels exist:$/) do |channels_table|
  channels_table.hashes.each do |channel_hash|
    Channel.create channel_hash
  end
end

Given(/^the following devices exist:$/) do |devices_table|
  devices_table.hashes.each do |device_hash|
    Device.create device_hash
  end
end 

Given(/^the following settopboxes exist:$/) do |settopboxes_table|
  settopboxes_table.hashes.each do |settopbox_hash|
    SetTopBox.create settopbox_hash
  end
end 

Then("the cost of {string} should be {int}") do |package_name, cost|
  package = StreamPackage.find_by(name: package_name)
  expect(cost).to eq(package.cost)
end

Then("the category of {string} should be {string}") do |channel_name, category|
  channel = Channel.find_by(name: channel_name)
  expect(category).to eq(channel.category)
end

Then(/^I go with "([^"]*)" from Channels$/) do |channels|
  channel_list = channels.split(', ')
  channel_ids = []
  channel_list.each do |channel|
    channel_ids << Channel.find_by(name: channel).id
  end
  find('input#channel_dropdown', visible:false).set(channel_ids)
end

Then(/^I go with "([^"]*)" from Category$/) do |category|
  first('input#category_dropdown', visible:false).set(category)
end

Then(/^I go with "([^"]*)" from Must have channels$/) do |channels|
  channel_list = channels.split(', ')
  channel_ids = []
  channel_list.each do |channel|
    channel_ids << Channel.find_by(name: channel).id
  end
  first('input#must_have_dropdown', visible:false).set(channel_ids)
end

Then(/^I go with "([^"]*)" from Would like to have channels$/) do |channels|
  channel_list = channels.split(', ')
  channel_ids = []
  channel_list.each do |channel|
    channel_ids << Channel.find_by(name: channel).id
  end
  first('input#good_to_have_dropdown', visible:false).set(channel_ids)
end
