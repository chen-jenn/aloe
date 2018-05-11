class CreateReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :reminders do |t|
      t.string :frequency
      t.datetime :last_reminder
      t.references :user, foreign_key: true
      t.references :individual_plant, foreign_key: true

      t.timestamps
    end
  end
end
