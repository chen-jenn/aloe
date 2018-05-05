class RemoveOptTempFromZoneComparisons < ActiveRecord::Migration[5.1]
  def change
    remove_column :zone_comparisons, :opt_temp
  end
end
