class RemoveCountryFromPlants < ActiveRecord::Migration[5.1]
  def change
    remove_column :plants, :country
  end
end
