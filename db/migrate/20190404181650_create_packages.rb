class CreatePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.string :name, null: false
      t.string :link
      t.float :cost
      t.boolean :DVR

      t.timestamps
    end
    add_index :packages, :name, unique: true
  end
end
