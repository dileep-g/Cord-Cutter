class Perference < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates(:rate, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 3})

  def Perference.delete_record(user_id)
    perferences = Perference.where(user_id: user_id).find_each
    perferences.each do |perference|
      Perference.destroy(perference.id)
    end
  end

  def Perference.create_record(user_id, must_have, would_have, ok_have)
    if must_have != nil
      must_have.each do |channel|
        Perference.create user_id: user_id, channel_id: channel, rate: 3 
      end
    end
    if would_have != nil
      would_have.each do |channel|
        Perference.create user_id: user_id, channel_id: channel, rate: 2 
      end
    end
    if ok_have != nil
      ok_have.each do |channel|
        Perference.create user_id: user_id, channel_id: channel, rate: 1 
      end
    end
  end

  def Perference.remove_redudant(must_have, would_have, ok_have)
    if !(must_have & would_have).empty?
      would_have = would_have - (must_have & would_have)
    end
    if !(must_have & ok_have).empty?
      ok_have = ok_have - (must_have & ok_have)
    end
    if !(ok_have & would_have).empty?
      ok_have = ok_have - (ok_have & would_have)
    end
    return must_have, would_have, ok_have
  end

  # find all package combinations that satisfy the must have channels
  def Perference.cut_cord(must_have)
    # array store the package combinations
    results = []

    must_have.each do |channel| # for each must have channel
# ------------------part 1 initialization------------------------------------    
      packages = [] # the corresponding packages for each channel
      results_new = [] # store results that combine exist result and new packages
      results_delete = [] # store original results combined with new packages
      packages_hash = Hash.new # store current channels' package hash
      packages_hash.default = false

      # find corresponding channels
      ProvideChannel.where(channel_id: channel).each do |provide|
        packages << provide.package_id
        packages_hash[provide.package_id] = true # remember all packages
      end # end package_id for

#------------------part 2 base case-----------------------------------------
      # add the first channel's packages to the result list
      if results.empty?         
        packages.each do |id|
          result_init = [id]
          results << result_init
        end
        next
      end
#----------------part 3 n to n+1 case----------------------------------------
      results.each do |result| # see every result
        flag_include = false
        result.each do |package| # search every package in the result
          # if some current channel's packages are already included in the result
          if packages_hash[package] == true             
            flag_include = true
            break # stop the loop
          end
        end
        # if none of the packages is included in this result
        if !flag_include
          # add new results based on current result and all channel's packages
          packages.each do |package|
            result_new = Array.new(result)
            result_new << package
            result_new.sort!
            results_new << result_new
          end
          results_delete << result # delete current result
        end
      end
      # change the results after loop
      results = results - results_delete
      results = results + results_new
    end
    return results.uniq
  end

  # find one package
  def Perference.one_package(must_have)
    # array store the package combinations
    results = []
    packages_hash = Hash.new # store current channels' package hash
    packages_hash.default = 0

    must_have.each do |channel| # for each must have channel
      # find corresponding channels
      ProvideChannel.where(channel_id: channel).each do |provide|
        packages_hash[provide.package_id] += 1
      end # end package_id for
    end
    packages_hash.each_key do |package|
      result = [package]
      results << result
    end
    return results
  end

  # recommend according to the user profile and preference
  def Perference.recommend_overall(results, user_id, budget, must_have, would_have, ok_have, dvr, flag_one_pack)
    # store user profile and result
    results_overall = []
    devices = []
    boxes = []
    OwnDevice.where(user_id: user_id).each do |own_device|
      devices << own_device.device_id
    end
    OwnBox.where(user_id: user_id).each do |own_box|
      boxes << own_box.set_top_box_id
    end

    # for every result
    results.each do |result|
      # use a hash to store the information needed to show
      result_hash = Hash.new

      # find name of packages
      packages = []
      result.each do |package|
        hash_package = {}
        hash_package[:name] = Package.find(package).name
        hash_package[:link] = Package.find(package).link
        packages << hash_package
      end
      result_hash[:package] = packages

      # find all information of packages
      result_devices = []
      result_boxes = []
      result_channels = []
      expense = 0.0
      flag_dvr = true

      result.each do |package|
        SupportDevice.where(package_id: package).each do |support_device|
          result_devices << support_device.device_id
        end
        SupportBox.where(package_id: package).each do |support_box|
          result_boxes << support_box.set_top_box_id
        end
        ProvideChannel.where(package_id: package).each do |provide_channel|
          result_channels << provide_channel.channel_id
        end
        expense = expense + Package.find(package).cost
        if Package.find(package).DVR == false
          flag_dvr = false
        end
      end
      
      # discard over-budget results
      if expense > budget.to_f
        next
      end

      # figure out whether the result support user's demands
      result_devices.uniq!
      result_boxes.uniq!
      if (devices - result_devices).empty?
        result_hash[:devices] = 1
      else
        result_hash[:devices] = 0
      end
      if (boxes - result_boxes).empty?
        result_hash[:boxes] = 1
      else
        result_hash[:boxes] = 0
      end
      result_hash[:expense] = expense
      if dvr == 'true' && flag_dvr == false
        result_hash[:dvr] = 0
      else
        result_hash[:dvr] = 1
      end

      count_must_have = 0
      result_hash[:must_have] = []
      count_would_have = 0
      result_hash[:would_have] = []
      count_ok_have = 0
      result_hash[:ok_have] = []
      must_have.each do |channel|
        if result_channels.include?(channel.to_i)
          count_must_have += 1
          result_hash[:must_have] << Channel.find(channel).name
        end
      end
      would_have.each do |channel|
        if result_channels.include?(channel.to_i)
          count_would_have += 1
          result_hash[:would_have] << Channel.find(channel).name
        end
      end
      ok_have.each do |channel|
        if result_channels.include?(channel.to_i)
          count_ok_have += 1
          result_hash[:ok_have] << Channel.find(channel).name
        end
      end
      result_hash[:score] = count_must_have * 50 + 
        count_would_have * 10 + 
        count_ok_have * 5 + 
        1000 / expense + 
        result_hash[:devices] * 5 + 
        result_hash[:boxes] * 5 + 
        result_hash[:dvr] * 5
      results_overall << result_hash
    end
    # sort by score
    results_overall.sort_by! {|hash| -hash[:score]}
    return results_overall
  end
end
