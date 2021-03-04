class Contact < ApplicationRecord
    belongs_to :user
    has_many :recent_events, dependent: :destroy

    validates :first_name, presence: true

    #accepts_nested_attributes_for :recent_events
end
