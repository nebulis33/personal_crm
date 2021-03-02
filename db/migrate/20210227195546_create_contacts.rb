class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.belongs_to :user
      t.string :first_name, null: false
      t.string :last_name
      t.string :nickname
      t.string :email
      t.string :phone_number
      t.string :address
      t.date :birthday

      t.timestamps
    end
  end
end
