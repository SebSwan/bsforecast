class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :sport
      t.integer :configuration
      t.string :label
      t.float :latitude
      t.float :longitude
      t.integer :wind_force_maxi
      t.integer :wind_force_mini
      t.string :wind_direction
      t.integer :tide_mini
      t.integer :tide_max
      t.boolean :low_tide
      t.boolean :mid_tide
      t.boolean :high_tide
      t.integer :coeff_mini
      t.integer :coeff_maxi
      t.integer :wave_direction
      t.integer :wave_height_mini
      t.integer :wave_height_maxi
      t.integer :periode_mini
      t.integer :periode_maxi
      t.string :windfinder
      t.string :windfindersuper
      t.string :shom

      t.timestamps
    end
  end
end
