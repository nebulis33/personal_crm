class RecentEventsController < ApplicationController
    def index
        @events = Contact.find(params[:contact_id]).recent_events.all
    end

    def new
        @event = RecentEvent.new
    end

    def create
        @contact = Contact.find(params[:contact_id])
        @event = Contact.find(params[:contact_id]).recent_events.new(event_params)
        if @event.save
            redirect_to contact_recent_events_url(@contact)
        else
            flash[:error] = @event.errors.full_messages
            redirect_back(fallback_location: @contact)
        end
    end

    private

        def event_params
            params.require(:recent_events).permit(:interaction_type, :description, :date)
        end
end
