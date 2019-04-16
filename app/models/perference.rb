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
    if would_have.each != nil
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

  def Perference.cut_cord(must_have)

    # array store the package combinations
    results = []

    must_have.each do |channel| # for each must have channel
# ------------------part 1 initialization------------------------------------    
      packages = [] # the corresponding packages for each channel
      results_new = []
      results_delete = []
      packages_hash = Hash.new
      packages_hash.default = false

      # find corresponding channels
      ProvideChannel.where(channel_id: channel).each do |provide|
        packages << provide.package_id
        packages_hash[provide.package_id] = true
      end # end package_id for

      if results.empty?
        packages.each do |id|
          result_init = [id]
          results << result_init
        end
        next
      end

      results.each do |result|
        result.each do |package|
          if packages_hash[package] == true

          end
        end
      end
      results = results - results_delete
      results = results + results_new
    end
    return results
  end
end
