class CreateSupportDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :support_devices do |t|
      t.belongs_to :package, index: true
      t.belongs_to :device, index: true

      t.timestamps
    end
  end
end
