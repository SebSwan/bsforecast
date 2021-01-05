class Spot < ApplicationRecord
  has_and_belongs_to_many :wind_directions, dependent: :destroy
  has_and_belongs_to_many :wave_directions, dependent: :destroy
  SPORT= ['Kite', 'Surf', 'Paragliding', 'Kite-foil', 'Surf-foil']
end
