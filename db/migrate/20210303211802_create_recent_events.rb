class CreateRecentEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :recent_events do |t|
      t.belongs_to :contact
      t.string :interaction_type, null: false
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
