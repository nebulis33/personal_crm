class UsersController < ApplicationController
    before_action :require_user, only: [:show]
    def index
       @recent_events = Event.includes(:contact).where(user_id: current_user.id).recent_events
       @upcoming_events = Event.includes(:contact).where(user_id: current_user.id).upcoming_events
       @need_to_contact = current_user.need_to_contact
       @birthdays = current_user.birthdays
    end

    def show
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
