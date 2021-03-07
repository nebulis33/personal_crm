class CreateUpcomingEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :upcoming_events do |t|
      t.belongs_to :contact
      t.belongs_to :user
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
