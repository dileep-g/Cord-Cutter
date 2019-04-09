class OwnBox < ApplicationRecord
  belongs_to :user
  belongs_to :set_top_box

  def OwnBox.delete_record(user_id)
    own_boxes = OwnBox.where(user_id: user_id).find_each
    own_boxes.each do |own_box|
      OwnBox.destroy(own_box.id)
    end
  end

  def OwnBox.create_record(user_id, items)
    items.each do |item|
      OwnBox.create user_id: user_id, set_top_box_id: item
    end
  end
end
