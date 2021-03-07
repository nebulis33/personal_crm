class UsersController < ApplicationController
    def index
       @recent_events = RecentEvent.includes(:contact).where(user_id: current_user.id)
    end
end
