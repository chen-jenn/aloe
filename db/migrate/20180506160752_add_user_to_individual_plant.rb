class AddUserToIndividualPlant < ActiveRecord::Migration[5.1]
  def change
    add_reference :individual_plants, :user, foreign_key: true
  end
end
