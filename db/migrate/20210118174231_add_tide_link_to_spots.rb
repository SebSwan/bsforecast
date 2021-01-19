class AddTideLinkToSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :tide_link, :string
  end
end
