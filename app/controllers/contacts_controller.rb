class ContactsController < ApplicationController
    skip_before_action :require_login
    def new
      @contact = Contact.new
    end
  
    def create
      @contact = Contact.new(params[:contact])
      @contact.request = request
      if @contact.deliver
        flash[:notice] = 'Thank you for your message. We will contact you soon!'
        redirect_to root_path
      else
        flash.now[:error] = 'Cannot send message.'
        redirect_to root_path
      end
    end
  end