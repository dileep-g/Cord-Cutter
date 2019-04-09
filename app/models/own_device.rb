class OwnDevice < ApplicationRecord
  belongs_to :user
  belongs_to :device

  def OwnDevice.delete_record(user_id)
    own_devices = OwnDevice.where(user_id: user_id).find_each
    own_devices.each do |own_device|
      OwnDevice.destroy(own_device.id)
    end
  end

  def OwnDevice.create_record(user_id, items)
    items.each do |item|
      OwnDevice.create user_id: user_id, device_id: item
    end
  end
end
