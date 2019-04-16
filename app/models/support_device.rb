class SupportDevice < ApplicationRecord
  belongs_to :package
  belongs_to :device
  
  def SupportDevice.delete_record(package_id)
    support_devices = SupportDevice.where(package_id: package_id).find_each
    support_devices.each do |support_device|
      SupportDevice.destroy(support_device.id)
    end
  end

  
  def SupportDevice.create_record(device_id, items)
    items.each do |item|
      SupportDevice.create package_id: device_id, device_id: item
    end
  end
  
end
