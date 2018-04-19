class CreatePlants < ActiveRecord::Migration[5.1]
  def change
    create_table :plants do |t|
      t.text :species_name
      t.text :common_name
      t.string :city
      t.string :country
      t.text :climate_zone

      t.timestamps
    end
  end
end
