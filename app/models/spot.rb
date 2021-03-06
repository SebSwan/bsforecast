class Spot < ApplicationRecord
  has_and_belongs_to_many :wind_directions, dependent: :destroy
  has_and_belongs_to_many :wave_directions, dependent: :destroy
  after_create :load_after_create
  after_save :load_after_save

  SPORT= ['K kite', 'S Surf', 'P Paragliding', 'KF Kite-foil', 'SF Surf-foil','PD Paddle','SW Swim','F Fishing']

  def load_after_create
    Windfinder.dataset_quick(self[:windfinder])
    Windfinder.dataset_quick(self[:tide_link]) if self[:tide_link].present?
  end

  def load_after_save
    Windfinder.dataset_quick(self[:windfinder])
    Windfinder.dataset_quick(self[:tide_link]) if self[:tide_link].present?
  end
end
