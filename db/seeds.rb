# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Spot.create ({
  :configuration => 0,
  :name => 'Sillon de Talbert',
  :sport => 'kite',
  :label => 'sessions classiques',
  :latitude => nil,
  :longitude => nil,
  :wind_force_mini => 13,
  :wind_force_maxi => 45,
  :wind_direction => %w[W WNW NW NNW N NNE NE ENE E],
  :tide_mini => 0,
  :tide_max => 13,
  :low_tide => false,
  :mid_tide => false,
  :high_tide => false,
  :coeff_mini => 35,
  :coeff_maxi => 115,
  :wave_height_mini => nil,
  :wave_height_maxi => nil,
  :wave_direction => nil,
  :periode_mini => nil,
  :periode_maxi => nil,
  :windfinder => "https://www.windfinder.com/forecast/sillon_du_talbert",
  :windfindersuper => "https://www.windfinder.com/weatherforecast/sillon_du_talbert",
  :shom => "https://services.data.shom.fr/oceano/render/text?duration=4&delta-date=0&lon=-3.102264404296875&lat=48.883005362568866&utc=2&lang=fr"
})
