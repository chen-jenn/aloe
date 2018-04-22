class RemoveCommonNameColumnFromPlants < ActiveRecord::Migration[5.1]
  def change
    remove_column :plants, :common_name
  end
end
