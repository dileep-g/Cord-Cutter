class Antenna < ApplicationRecord
  belongs_to :user
  belongs_to :channel

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
end
