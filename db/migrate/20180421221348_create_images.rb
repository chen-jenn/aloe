class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.text :url
      t.references :plant, foreign_key: true

      t.timestamps
    end
  end
end
