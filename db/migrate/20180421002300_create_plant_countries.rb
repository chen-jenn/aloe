class CreatePlantCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :plant_countries do |t|
      t.references :plant, foreign_key: true
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
