class RemoveColumnsToSpots < ActiveRecord::Migration[6.0]
  def change
    remove_column :spots, :wave_direction, :integer
    remove_column :spots, :wind_direction, :string
  end

end
