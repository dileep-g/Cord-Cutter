class CreatePerferences < ActiveRecord::Migration[5.1]
  def change
    create_table :perferences do |t|
      t.belongs_to :user, index: true
      t.belongs_to :channel, index: true
      t.integer :rate, default: 0

      t.timestamps
    end
  end
end
