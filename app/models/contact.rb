class Contact < ApplicationRecord
    belongs_to :user
    has_many :events, dependent: :destroy

    validates :first_name, presence: true
    has_one_attached :contact_image

    before_validation :set_nils

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

    def display_contact_image
        if contact_image.key
            self.contact_image.key
        else
            "default_ilnk3n.jpg"
        end
    end

    def display_birthday
        if birthday
            birthday.strftime("%m/%d/%y")
        else
            false
        end
    end

    def set_nils
        self.address = nil if self.address.blank?
        self.phone_number = nil if self.phone_number.blank?
        self.email = nil if self.email.blank?
    end
end
