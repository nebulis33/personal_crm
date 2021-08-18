class UsersController < ApplicationController
    before_action :require_user, only: [:show]
    def index
       @recent_events = Event.includes(contact: [contact_image_attachment: :blob]).where(user_id: current_user.id).recent_events
       @upcoming_events = Event.includes(contact: [contact_image_attachment: :blob]).where(user_id: current_user.id).upcoming_events
       @need_to_contact = current_user.need_to_contact
       @birthdays = current_user.birthdays
    end

    def show
        @contacts = current_user.contacts.count
        @events = current_user.events.count
    end

    def weekly_rundown
        @upcoming_events = Event.includes(:contact).where(user_id: self.id).upcoming_events
        #TODO: upcoming events should probably be in the user model at this rate, in which case Contact#upcoming_events needs to be moved as well
        NotifierMailer.upcoming_dates.(self, self.birthdays, @upcoming_events).deliver
    end

    private
        def require_user
            user = User.find(params[:id])
            unless user == current_user
                response = {error: "Thats not you"}
                render json: response, status: 401
            end
        end
end
