class RemoveImages < ActiveRecord::Migration[5.1]
  def change
    drop_table :images
  end
end
