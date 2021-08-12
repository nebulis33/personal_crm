class ContactsController < ApplicationController
    before_action :require_ownership, except: [:index, :new, :create]

    def index
        @contacts = Contact.includes(contact_image_attachment: :blob).where(user_id: current_user.id).order('first_name')
    end

    def show
        @contact = Contact.find(params[:id])

        @last_activity = @contact.last_activity
        @last_contact = @contact.last_contact

        @upcoming_events = @contact.upcoming_events
        @recent_events = @contact.recent_events
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
            params.require(:contact).permit(:user_id, :first_name, :last_name, :contact_image, :nickname, :birthday, :address, :email, :phone_number)
        end

        def require_ownership
            contact = Contact.find(params[:id])
            unless contact.user_id == current_user.id
                response = {error: "You don't own that contact"}
                render json: response, status: 401
            end
        end
end
