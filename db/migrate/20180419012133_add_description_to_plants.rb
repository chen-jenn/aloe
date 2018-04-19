class AddDescriptionToPlants < ActiveRecord::Migration[5.1]
  def change
    add_column :plants, :description, :text
  end
end
