class CreateSupportBoxes < ActiveRecord::Migration[5.1]
  def change
    create_table :support_boxes do |t|
      t.belongs_to :package, index: true
      t.belongs_to :set_top_box, index: true

      t.timestamps
    end
  end
end
