class AddLatLongToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :climate_zone, :string 
  end
end
