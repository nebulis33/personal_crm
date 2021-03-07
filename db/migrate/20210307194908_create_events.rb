class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.belongs_to :contact
      t.belongs_to :user
      t.string :interaction_type, null: false
      t.text :description
      t.datetime :date, null: false

      t.timestamps
    end
  end
end
