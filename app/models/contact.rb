class Contact < ApplicationRecord
    belongs_to :user
    has_many :recent_events, dependent: :destroy
    has_many :upcoming_events, dependent: :destroy

    validates :first_name, presence: true

    #accepts_nested_attributes_for :recent_events

    def full_name
        if self.nickname
            "#{self.first_name || ''} #{self.last_name || ''} (#{self.nickname})"
        else
            "#{self.first_name || ''} #{self.last_name || ''}"
        end
    end
end
