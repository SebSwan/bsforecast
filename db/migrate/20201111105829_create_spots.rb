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

# spot_setup1 = {
#   # :configuration => 0,
#   # :name => 'Sillon de Talbert',
#   # :sport => 'kite',
#   # :label => 'sessions classiques',
#   # :latitude => nil,
#   # :longitude => nil,
#   # :wind_force_mini => 13,
#   # :wind_force_maxi => 45,
#   :wind_direction => %w[W WNW NW NNW N NNE NE ENE E],
#   :tide_mini => 0,
#   :tide_max => 13,
#   :low_tide => false,
#   :mid_tide => false,
#   :high_tide => false,
#   :coeff_mini => 35,
#   :coeff_maxi => 115,
#   :wave_height_mini => nil,
#   :wave_height_maxi => nil,
#   :wave_direction => nil,
#   :periode_mini => nil,
#   :periode_maxi => nil,
#   :windfinder => "https://www.windfinder.com/forecast/sillon_du_talbert",
#   :windfindersuper => "https://www.windfinder.com/weatherforecast/sillon_du_talbert",
#   :shom => "https://services.data.shom.fr/oceano/render/text?duration=4&delta-date=0&lon=-3.102264404296875&lat=48.883005362568866&utc=2&lang=fr"
# }
