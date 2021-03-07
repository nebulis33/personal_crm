class ContactsController < ApplicationController
    #:before_action :authenticate_user!
    
    def index
        @contacts = Contact.where(user_id: current_user.id)
    end

    def show
        @contact = Contact.find(params[:id])
    end

    def new
        @contact = current_user.contacts.new
    end

    def create
        @contact = current_user.contacts.new(contact_params)
        if @contact.save
            redirect_to contacts_url
        else
            flash[:error] = @contact.errors.full_messages
            render :new
        end
    end

    def update

    end

    def destroy

    end

    private

        def contact_params
            params.require(:contact).permit(:user_id, :first_name, :last_name, :nickname, :email, :phone_number, :address, :birthday)
        end
end
