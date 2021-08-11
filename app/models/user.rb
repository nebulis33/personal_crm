class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_many :contacts, -> {order 'first_name ASC'}, dependent: :destroy #this doesn't seem to do anything? There is also an order when displaying in the contacts index controller action
  has_many :events, dependent: :destroy

  def need_to_contact
    query = <<-SQL
    SELECT first_name, contact_id, e.max_date
      FROM contacts
      JOIN (SELECT DISTINCT contact_id, MAX(date) AS max_date
        FROM events
        WHERE user_id = #{self.id}
        GROUP BY contact_id) e
      ON contacts.id = e.contact_id
      WHERE e.max_date <= current_date - interval '7 days'
      ORDER BY e.max_date ASC
      LIMIT 5
    SQL

    pg_arr = ActiveRecord::Base.connection.execute(query).values

    users = []
    pg_arr.each do |a|
      u = Contact.find(a[1]).contact_image.key || false
      users << [*a, u]
    end

    return users

  end
  ## consider moving to another model

  def birthdays
    Contact.where("user_id = ? AND birthday <= ?", self.id, 1.week.from_now)
  end
end
