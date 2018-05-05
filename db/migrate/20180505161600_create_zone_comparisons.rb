class CreateZoneComparisons < ActiveRecord::Migration[5.1]
  def change
    create_table :zone_comparisons do |t|
      t.string :user_zone
      t.string :plant_zone
      t.string :water_freq

      t.timestamps
    end
  end
end
