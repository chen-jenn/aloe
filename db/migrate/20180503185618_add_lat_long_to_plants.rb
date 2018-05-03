class AddLatLongToPlants < ActiveRecord::Migration[5.1]
  def change
    add_column :plants, :latitude, :float
    add_column :plants, :longitude, :float
  end
end
