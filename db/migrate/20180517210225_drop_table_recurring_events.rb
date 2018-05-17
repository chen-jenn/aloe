class DropTableRecurringEvents < ActiveRecord::Migration[5.1]
  def change
    drop_table :recurring_events
  end
end
