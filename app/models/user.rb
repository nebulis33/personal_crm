class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_many :contacts, dependent: :destroy
  has_many :events, dependent: :destroy

  def need_to_contact
    Contact.where("user_id = ? AND updated_at <= ?", self.id, 1.week.ago).limit(5)
  end
end
