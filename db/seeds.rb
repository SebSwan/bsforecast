# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Spot.create ({
  # :configuration => 0,
  :name => 'Sillon de Talbert',
  :sport => 'K kite',
  :label => 'sessions classiques',
  :latitude => nil,
  :longitude => nil,
  :wind_force_mini => 13,
  :wind_force_maxi => 45,
  :tide_mini => 0,
  :tide_max => nil,
  :low_tide => false,
  :mid_tide => false,
  :high_tide => false,
  :coeff_mini => nil,
  :coeff_maxi => nil,
  :wave_height_mini => nil,
  :wave_height_maxi => nil,
  :wave_direction => nil,
  :periode_mini => nil,
  :periode_maxi => nil,
  :windfinder => "https://www.windfinder.com/forecast/sillon_du_talbert",
  :windfindersuper => "https://www.windfinder.com/weatherforecast/sillon_du_talbert",
  :shom => "https://services.data.shom.fr/oceano/render/text?duration=4&delta-date=0&lon=-3.102264404296875&lat=48.883005362568866&utc=2&lang=fr"
})

# WindDirection.create(direction:"No Wind")
WindDirection.create(direction:"N")
WindDirection.create(direction:"NNW")
WindDirection.create(direction:"NW")
WindDirection.create(direction:"WNW")
WindDirection.create(direction:"W")
WindDirection.create(direction:"WSW")
WindDirection.create(direction:"SW")
WindDirection.create(direction:"SSW")
WindDirection.create(direction:"S")
WindDirection.create(direction:"SSE")
WindDirection.create(direction:"SE")
WindDirection.create(direction:"ESE")
WindDirection.create(direction:"E")
WindDirection.create(direction:"ENE")
WindDirection.create(direction:"NE")
WindDirection.create(direction:"NNE")

# WaveDirection.create(direction:"No Wave")
WaveDirection.create(direction:"N")
WaveDirection.create(direction:"NNW")
WaveDirection.create(direction:"NW")
WaveDirection.create(direction:"WNW")
WaveDirection.create(direction:"W")
WaveDirection.create(direction:"WSW")
WaveDirection.create(direction:"SW")
WaveDirection.create(direction:"SSW")
WaveDirection.create(direction:"S")
WaveDirection.create(direction:"SSE")
WaveDirection.create(direction:"SE")
WaveDirection.create(direction:"ESE")
WaveDirection.create(direction:"E")
WaveDirection.create(direction:"ENE")
WaveDirection.create(direction:"NE")
WaveDirection.create(direction:"NNE")

