class RecentEventsController < ApplicationController
    def index
        
    end

    def new
        @event = RecentEvent.new
    end

    def create
        @event = RecentEvent.new(event_params)
        if @event.save
            redirect_to contacts_url
        else
            flash[:error] = @event.errors.full_messages
            render :new
        end
    end

    private

        def event_params
            params.require(:recent_event).permit(:interaction_type, :description, :date, :contact_id)
        end
end
