class EventsController < ApplicationController
    before_action :require_event_ownership, only: [:show, :edit, :update, :destroy]
    before_action :require_contact_ownership, only: [:new, :create]

    def index
        @contact = Contact.find(params[:contact_id])
        @events = @contact.events.order(date: :desc)
    end

    def new
        @event = Contact.find(params[:contact_id]).events.new
    end

    def create
        @contact = Contact.find(params[:contact_id])
        @event = @contact.events.new(event_params)
        @event.user_id = current_user.id
        if @event.save
            # redirect_to contact_events_url(@contact) when the "all events" calendar has more functionality/js
            redirect_to @contact
        else
            flash[:error] = @event.errors.full_messages
            redirect_back(fallback_location: @contact)
        end
    end

    def edit
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])
        if @event.update(edit_event_params)
            flash[:success] = "event updated!"
            redirect_to contact_path(@event.contact)
        else
            flash.now[:error] = @event.errors.full_messages
            render :edit
        end
    end

    def destroy
        @event = Event.find(params[:id])
        if @event.destroy
            flash[:success] = "Event canceled"
            redirect_to root_url
        else
            flash[:error] = @event.errors.full_messages
            redirect_to root_url
        end
    end

    def overview
        @events = current_user.events
    end

    private

        def event_params
            params.require(:events).permit(:interaction_type, :description, :date)
        end

        def edit_event_params
            params.require(:event).permit(:interaction_type, :description, :date)
        end

        def require_event_ownership
            event = Event.find(params[:id])
            unless event.user_id == current_user.id
                response = {error: "You don't own that event"}
                render json: response, status: 401
            end
        end

        def require_contact_ownership
            contact = Contact.find(params[:contact_id])
            unless contact.user_id == current_user.id
                response = {error: "You don't own that contact"}
                render json: response, status: 401
            end
        end
end
