class ContactsController < ApplicationController
    before_action :require_ownership, except: [:index, :new, :create]

    def index
        @contacts = Contact.where(user_id: current_user.id)
    end

    def show
        @contact = Contact.includes(:events).find(params[:id])
        @last_activity_type = @contact.last_activity ? @contact.last_activity.interaction_type : 'No recent activities!'
        @last_activity_date = @contact.last_activity ? @contact.last_activity.date.strftime("%m/%d/%y") : ''

        @last_contact_type = @contact.last_contact ? @contact.last_contact.interaction_type : 'No recent contact!'
        @last_contact_date = @contact.last_contact ? @contact.last_contact.date.strftime("%m/%d/%Y") : ''

        @upcoming_event = @contact.events.upcoming_events ? @contact.events.upcoming_events.first : nil
        @past_events = @contact.events.recent_events.limit(5)
    end

    def new
        @contact = current_user.contacts.new
    end

    def create
        @contact = current_user.contacts.new(contact_params)
        if @contact.save
            flash[:success] = "#{@contact.first_name} was succesfully saved!"
            redirect_to contacts_url
        else
            flash.now[:error] = @contact.errors.full_messages
            render :new
        end
    end

    def edit
        @contact = Contact.find(params[:id])
    end

    def update
        @contact = Contact.find(params[:id])
        if @contact.update(contact_params)
            flash[:success] = "Contact updated!"
            redirect_to @contact
        else
            flash.now[:error] = @contact.errors.full_messages
            render :edit
        end
    end

    def destroy
        @contact = Contact.find(params[:id])
        if @contact.destroy
            flash[:success] = 'Contact successfully deleted'
            redirect_to contacts_url
        else
            flash[:error] = @contact.errors.full_messages
            redirect_back(fallback_location: contacts_url)
        end
    end

    private

        def contact_params
            params.require(:contact).permit(:user_id, :first_name, :last_name, :nickname, :email, :phone_number, :address, :birthday)
        end

        def require_ownership
            contact = Contact.find(params[:id])
            unless contact.user_id == current_user.id
                response = {error: "You don't own that contact"}
                render json: response, status: 401
            end
        end
end
