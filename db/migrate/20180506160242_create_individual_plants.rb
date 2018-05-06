class CreateIndividualPlants < ActiveRecord::Migration[5.1]
  def change
    create_table :individual_plants do |t|
      t.string :species_name
      t.string :common_name # pick the first one or so
      t.string :individual_name #e.g. 'George'
      t.text :description
      t.string :ranking
      t.string :optimal_temp
      t.string :sunlight
      t.string :water_frequency 

      t.timestamps
    end
  end
end
