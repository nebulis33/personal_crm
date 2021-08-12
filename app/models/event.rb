class Event < ApplicationRecord
    validates :date, presence: true
    validates :interaction_type, inclusion: {in: %w(call text message videochat email mail solo_encounter group_encounter)}
    
    belongs_to :contact
    belongs_to :user

    delegate :contact_image, :first_name, :display_contact_image, to: :contact

    scope :recent_events, -> {where('date < ?', Date.today).order('date DESC').limit(6)}
    scope :upcoming_events, -> {where('date >= ?', Date.today).order(:date).limit(6)}
end
