class AddUserToPlant < ActiveRecord::Migration[5.1]
  def change
    add_reference :plants, :user, foreign_key: true
  end
end
