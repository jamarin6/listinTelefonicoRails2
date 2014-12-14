class Users::ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  def index
    @user = User.find(params[:user_id])
    @contacts = @user.contacts.order(:nombre).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1s
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    @user = User.find(params[:user_id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @user = User.find(params[:user_id])
    #@user.contacts = Contact.new(params[:contact])
    @contact = @user.contacts.create(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to user_contact_path(@user, @contact), notice: 'Contact was successfully created.' } #manda al show de contact
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @user = User.find(params[:user_id])
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact].except(:user_id)) # except es para q no me cambien el user_id
        format.html { redirect_to user_contact_path(@user, @contact), notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @user = User.find(params[:user_id])
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to user_contacts_path(@user), notice: 'Contact was successfully deleted.'  }
      format.json { head :no_content }
    end
  end
end
