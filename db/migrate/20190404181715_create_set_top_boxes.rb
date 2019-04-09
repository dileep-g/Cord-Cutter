class CreateSetTopBoxes < ActiveRecord::Migration[5.1]
  def change
    create_table :set_top_boxes do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :set_top_boxes, :name, unique: true
  end
end
