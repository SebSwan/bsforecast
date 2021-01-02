class CreateWaveDirections < ActiveRecord::Migration[6.0]
  def change
    create_table :wave_directions do |t|
      t.string :direction

      t.timestamps
    end
  end
end
