class CreateOwnDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :own_devices do |t|
      t.belongs_to :user, index: true
      t.belongs_to :device, index: true

      t.timestamps
    end
  end
end
