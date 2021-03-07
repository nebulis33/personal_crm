class EventsController < ApplicationController
    def index
        @events = Contact.find(params[:contact_id]).events.all
    end

    def new
        @event = Event.new
    end

    def create
        @contact = Contact.find(params[:contact_id])
        @event = Contact.find(params[:contact_id]).events.new(event_params)
        @event.user_id = current_user.id
        if @event.save
            redirect_to contact_events_url(@contact)
        else
            flash[:error] = @event.errors.full_messages
            redirect_back(fallback_location: @contact)
        end
    end

    private

        def event_params
            params.require(:events).permit(:interaction_type, :description, :date)
        end
end
