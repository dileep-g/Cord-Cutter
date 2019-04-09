class CreateProvideChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :provide_channels do |t|
      t.belongs_to :package, index: true
      t.belongs_to :channel, index: true

      t.timestamps
    end
  end
end
