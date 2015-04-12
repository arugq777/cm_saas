class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact.save
  end

end