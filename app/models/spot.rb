class Spot < ApplicationRecord
  has_and_belongs_to_many :wind_directions, dependent: :destroy
  has_and_belongs_to_many :wave_directions, dependent: :destroy
  SPORT= ['K kite', 'S Surf', 'P Paragliding', 'KF Kite-foil', 'SF Surf-foil','PD Paddle','SW Swim','F Fishing']
end
