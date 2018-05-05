class DropZonecomparison < ActiveRecord::Migration[5.1]
  def change
    drop_table :zone_comparisons
  end
end
