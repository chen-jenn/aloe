class CreateRecurringEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :recurring_events do |t|
      t.string :reminder
      t.string :time
      t.integer :day
      t.belongs_to :individual_plant, foreign_key: true

      t.timestamps
    end
  end
end
