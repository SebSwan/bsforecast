class CreateStandardDataSets < ActiveRecord::Migration[6.0]
  def change
    create_table :standard_data_sets do |t|
      t.string :model
      t.string :spot_name
      t.string :data_day_name
      t.date :data_time
      t.date :data_hour
      t.date :data_tide
      t.integer :data_ws
      t.integer :data_wg
      t.integer :data_wdeg
      t.integer :data_wdir

      t.timestamps
    end
  end
end
