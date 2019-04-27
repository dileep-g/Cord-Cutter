class Antenna < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  def Antenna.covered_channels(user_id)
    channels_names = []
    antennas = Antenna.where(user_id: user_id).find_each
    antennas.each do |antenna|
      channels_names << Channel.find(antenna.channel_id).name
    end
    return channels_names
  end
  def Antenna.delete_record(user_id)
    antennas = Antenna.where(user_id: user_id).find_each
    antennas.each do |antenna|
      Antenna.destroy(antenna.id)
    end
  end

  def Antenna.create_record(user_id, items)
    items.each do |item|
      Antenna.create user_id: user_id, channel_id: item
    end
  end

  def Antenna.remove_channel(user_id, channels)
    if channels == nil
      return []
    end
    channels_remove = []
    channels_hash = Hash.new
    channels_hash.default = false
    Antenna.where(user_id: user_id).each do |antenna|
      channels_hash[antenna.channel_id] = true
    end
    channels.each do |channel|
      if channels_hash[channel]
        channels_remove << channel
      end
    end
    channels = channels - channels_remove
    return channels
  end
end
