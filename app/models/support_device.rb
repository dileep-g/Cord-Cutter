class SupportDevice < ApplicationRecord
  belongs_to :package
  belongs_to :device
  
  def SupportDevice.delete_record(device_id)
    support_devices = SupportDevice.where(device_id: device_id).find_each
    support_devices.each do |support_device|
      SupportDevice.destroy(support_device.id)
    end
  end

  
  def SupportDevice.create_record(device_id, items)
    items.each do |item|
      SupportDevice.create device_id: device_id, package_id: item
    end
  end
  
end
