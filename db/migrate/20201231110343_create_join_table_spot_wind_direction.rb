class CreateJoinTableSpotWindDirection < ActiveRecord::Migration[6.0]
  def change
    create_join_table :spots, :wind_directions do |t|
      # t.index [:spot_id, :wind_direction_id]
      # t.index [:wind_direction_id, :spot_id]
    end
  end
end
