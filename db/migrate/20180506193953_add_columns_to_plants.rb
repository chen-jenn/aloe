class AddColumnsToPlants < ActiveRecord::Migration[5.1]
  def change
   add_column :plants, :sunlight, :string
   add_column :plants, :temp_min, :float
   add_column :plants, :temp_max, :float
  end
end
