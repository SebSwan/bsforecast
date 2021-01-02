class Spot < ApplicationRecord
  has_and_belongs_to_many :wind_directions, dependent: :destroy
  has_and_belongs_to_many :wave_directions, dependent: :destroy
  SPORT= ['Kite', 'Surf', 'Paragliding']
  # DIRECTION = ['N','NNW','NW','WNW','W','WSW','SW','SSW','S','SSE','SE','ESE','E','ENE','NE','NNE']
end
