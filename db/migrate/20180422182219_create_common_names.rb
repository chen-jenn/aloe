class CreateCommonNames < ActiveRecord::Migration[5.1]
  def change
    create_table :common_names do |t|
      t.text :name
      t.references :plant, foreign_key: true

      t.timestamps
    end
  end
end
