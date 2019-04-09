class CreateOwnBoxes < ActiveRecord::Migration[5.1]
  def change
    create_table :own_boxes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :set_top_box, index: true

      t.timestamps
    end
  end
end
