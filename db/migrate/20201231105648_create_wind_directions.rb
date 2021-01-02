class CreateWindDirections < ActiveRecord::Migration[6.0]
  def change
    create_table :wind_directions do |t|
      t.string :direction

      t.timestamps
    end
  end
end
