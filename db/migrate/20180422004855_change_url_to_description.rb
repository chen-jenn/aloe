class ChangeUrlToDescription < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :url, :description
  end
end
