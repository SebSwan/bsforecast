class JoinTableSpotWaveDirection < ActiveRecord::Migration[6.0]
  def change
    create_join_table :spots, :wave_directions do |t|
      # t.index [:spot_id, :wave_direction_id]
      # t.index [:wave_direction_id, :spot_id]
    end
  end
end
