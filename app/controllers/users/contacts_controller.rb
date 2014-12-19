class Users::ContactsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @contacts = @user.contacts.order(:nombre).page params[:page]
  end

  def show
    @contact = Contact.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    @contact = Contact.new
    @user = User.find(params[:user_id])
  end

  def edit
    @contact = Contact.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @contact = @user.contacts.create(params[:contact])

    if @contact.save
      redirect_to user_contact_path(@user, @contact), notice: 'Contact was successfully created.' #manda al show de contact
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:user_id])
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact].except(:user_id)) # except es para q no me cambien el user_id
      redirect_to user_contact_path(@user, @contact), notice: 'Contact was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to user_contacts_path(@user), notice: 'Contact was successfully deleted.'
  end
end