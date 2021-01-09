class AddColumnToSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :active, :boolean, :default => true
  end
end
