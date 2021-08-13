class Contact < ApplicationRecord
    belongs_to :user
    has_many :events, dependent: :destroy

    validates :first_name, presence: true
    has_one_attached :contact_image

    accepts_nested_attributes_for :events, allow_destroy: true

    before_validation :set_nils

    def full_name
        if self.nickname
            "#{self.first_name || ''} #{self.last_name || ''} (#{self.nickname})"
        else
            "#{self.first_name || ''} #{self.last_name || ''}"
        end
    end
    
    def last_activity
        Event.select(:date, :interaction_type).where(contact_id: self.id)
        .where(interaction_type: ["group_encounter", "solo_encounter"])
        .last
    end
    
    def last_contact
        Event.select(:date, :interaction_type).where(contact_id: self.id)
        .where.not(interaction_type: ["group_encounter", "solo_encounter"])
        .last
    end
    
    def upcoming_events
        Event.where('contact_id = ? AND date >= ?', self.id, Date.today).order('date DESC').limit(3)
    end

    def recent_events
        Event.where('contact_id = ? AND date < ?', self.id, Date.today).order('date ASC').limit(3)
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
