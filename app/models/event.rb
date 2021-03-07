class Event < ApplicationRecord
    validates :date, presence: true
    validates :interaction_type, inclusion: {in: %w(call text message videochat email mail solo_encounter group_encounter)}
    
    belongs_to :contact
    belongs_to :user

    scope :recent_events, -> {where('date < ?', Date.today)}
    scope :upcoming_events, -> {where('date > ?', Date.today)}
end
