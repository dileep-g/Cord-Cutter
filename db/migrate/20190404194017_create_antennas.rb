class CreateAntennas < ActiveRecord::Migration[5.1]
  def change
    create_table :antennas do |t|
      t.belongs_to :user, index: true
      t.belongs_to :channel, index: true

      t.timestamps
    end
  end
end
