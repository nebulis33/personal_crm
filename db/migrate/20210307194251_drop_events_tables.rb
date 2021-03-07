class DropEventsTables < ActiveRecord::Migration[6.1]
  def up
    drop_table :recent_events
    drop_table :upcoming_events
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
