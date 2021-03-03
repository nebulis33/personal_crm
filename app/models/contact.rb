class Contact < ApplicationRecord
    belongs_to :user
    has_many :recent_events

    validates :first_name, presence: true
end
