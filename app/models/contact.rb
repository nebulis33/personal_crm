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

    def last_activity
        Event.where(contact_id: self.id, interaction_type: "solo_encounter")
            .or(Event.where(contact_id: self.id, interaction_type: "group_encounter"))
            .last
    end

    def last_contact
        Event.where(contact_id: self.id)
            .and(Event.where.not(interaction_type: ["solo_encounter", "group_encounter"]))
            .last
    end
end
