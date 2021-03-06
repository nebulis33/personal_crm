class RecentEvent < ApplicationRecord
    belongs_to :contact
    belongs_to :user

    validates :interaction_type, inclusion: {in: %w(call text message videochat email mail solo_encounter group_encounter)}
end
