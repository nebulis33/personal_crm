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
    SELECT first_name, contact_id, e.max_date, asb.key
      FROM contacts
      JOIN (SELECT DISTINCT contact_id, MAX(date) AS max_date
        FROM events
        WHERE user_id = #{self.id}
        GROUP BY contact_id) e
      ON contacts.id = e.contact_id
      LEFT JOIN active_storage_attachments asa
      ON e.contact_id = asa.record_id
      LEFT JOIN active_storage_blobs asb
      ON asa.blob_id = asb.id
      WHERE e.max_date <= current_date - interval '7 days'
      ORDER BY e.max_date ASC
      LIMIT 6
    SQL

    ActiveRecord::Base.connection.execute(query).values
  end
  ## consider moving need_to_contact to another model. Also, try to rewrite using rails vs raw sql.

  def birthdays
    Contact
      .where("user_id = :id AND extract(DOY FROM birthday) <= :next_week AND extract(DOY FROM birthday) >= :today", id: self.id, next_week: 1.week.from_now.yday, today: Time.now.yday)
      .order(:first_name)
      .limit(6)
  end
end
