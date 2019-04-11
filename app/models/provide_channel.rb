class ProvideChannel < ApplicationRecord
  belongs_to :package
  belongs_to :channel
  
  # def Antenna.delete_record(user_id)
  #   antennas = Antenna.where(user_id: user_id).find_each
  #   antennas.each do |antenna|
  #     Antenna.destroy(antenna.id)
  #   end
  # end
  
  def ProvideChannel.delete_record(package_id)
    provide_channels = ProvideChannel.where(package_id: package_id).find_each
    provide_channels.each do |provide_channel|
      ProvideChannel.destroy(provide_channel.id)
    end
  end

  # def Antenna.create_record(user_id, items)
  #   items.each do |item|
  #     Antenna.create user_id: user_id, channel_id: item
  #   end
  # end
  
  def ProvideChannel.create_record(package_id, items)
    items.each do |item|
      ProvideChannel.create package_id: package_id, channel_id: item
    end
  end

end
