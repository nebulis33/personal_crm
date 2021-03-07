class UsersController < ApplicationController
    def index
       @recent_events = Event.includes(:contact).where(user_id: current_user.id).recent_events
       @upcoming_events = Event.includes(:contact).where(user_id: current_user.id).upcoming_events
    end

    def show
    end
end
