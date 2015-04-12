class ContactsController < ApplicationController

  def index
    @contacts = Contact.all

  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to new_contact_path, notice: 'saved!'
    elsif
      redirect_to new_contact_path, notice: 'NOPE.'
    end
        
  end

  private 
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end

end