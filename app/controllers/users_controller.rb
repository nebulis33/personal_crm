class UsersController < ApplicationController
    def index
       @recent_events = Event.includes(:contact).where(user_id: current_user.id).recent_events
       @upcoming_events = Event.includes(:contact).where(user_id: current_user.id).upcoming_events
       @need_to_contact = current_user.need_to_contact
    end

    def show
    end
end
