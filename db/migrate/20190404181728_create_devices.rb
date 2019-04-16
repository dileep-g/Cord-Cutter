class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :name,  null: false
      t.string :description

      t.timestamps
    end
    add_index :devices, :name, unique: true
  end
end
