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
      ContactMailer.contact_email(@contact.name, @contact.email, @contact.comments).deliver
      flash[:success] = 'You sent us an email!'
      redirect_to user_path(current_user.id)
    elsif
      flash[:danger] = 'NOPE.'
      redirect_to new_contact_path 
    end
        
  end

  private 
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end

end