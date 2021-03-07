class UsersController < ApplicationController
    def index
       @recent_events = Event.includes(:contact).where(user_id: current_user.id) #need to make a scope or something to have only past events
    end
end
