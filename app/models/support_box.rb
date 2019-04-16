class SupportBox < ApplicationRecord
  belongs_to :package
  belongs_to :set_top_box
  
  def SupportBox.delete_record(package_id)
    support_boxes = SupportBox.where(package_id: package_id).find_each
    support_boxes.each do |support_box|
      SupportBox.destroy(support_box.id)
    end
  end
  
  def SupportBox.create_record(set_top_box_id, items)
    items.each do |item|
      SupportBox.create package_id: set_top_box_id, set_top_box_id: item
    end
  end
end
