class ChangeColumnDescriptionToNotes < ActiveRecord::Migration[5.1]
  def change
    rename_column :plants, :description, :notes 
  end
end
