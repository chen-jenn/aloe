class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, index: {unique:true}
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :country
      t.string :email, index: {unique:true}
      t.string :password_digest

      t.timestamps
    end
  end
end
