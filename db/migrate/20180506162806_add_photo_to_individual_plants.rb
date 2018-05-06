class AddPhotoToIndividualPlants < ActiveRecord::Migration[5.1]
  def change
    add_column :individual_plants, :photo, :string
  end
end
