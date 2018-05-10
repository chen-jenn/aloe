class CreateRankings < ActiveRecord::Migration[5.1]
  def change
    create_table :rankings do |t|
      t.string :ease_of_care
      t.references :plant, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
