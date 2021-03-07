class Contact < ApplicationRecord
    belongs_to :user
    has_many :events, dependent: :destroy

    validates :first_name, presence: true

    def full_name
        if self.nickname
            "#{self.first_name || ''} #{self.last_name || ''} (#{self.nickname})"
        else
            "#{self.first_name || ''} #{self.last_name || ''}"
        end
    end
end
