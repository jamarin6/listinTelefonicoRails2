class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  before_filter :set_users_empty, :only=>[:index, :create, :update]
  
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

   ### #if params[:padre_id].present? #si viene el parametro :padre_id lo cojo

      #@numPadres = User.count(id: :padre_id)
      isFather = User.find(params[:padre_id]) rescue nil

      if (isFather == nil)
        #no hay user padre
        @noFather = true
      else
        #hay user
        @noFather = false
        @padre = User.find(params[:padre_id])
      end

      #if (@numPadres > 0) #si existe padre se podrá pintar
      #  @padre = User.find(params[:padre_id])
      #else
        #el padre ya fué borrado
        #@padre.nombre = "he was deleted"
      #end

    #else
      #@padre = nil #y si no viene xq no tenga padre (superUser), le digo q el padre no exite, = nill
   ### #end

    @userSons = User.where(padre_id: @user.id) #cojo los hijos de ese user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    #@padre = User.find(params[:id])

    if params[:id].present? #si viene el parametro :id lo cojo y es el id del padre  ########################
      @padre = User.find(params[:id])
     else
      #@padre = @user #y si no viene xq no tenga padre (superUser), le digo q el padre es el mismo user
      @padre = nil
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    #@padre = User.find(params[:padre_id])

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(:id => @user.id, :padre_id => @user.padre_id), notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        #format.html { redirect_to users_path, notice: @user.errors.messages[:nombre] } #muestra los errores guardados en :nombre
        #format.html { redirect_to new_user_path(:id => params[:padre.id]) }
        format.html { redirect_to users_path, notice: @user.errors.messages }
        #format.html { redirect_to new_user_path, notice: @user.errors.messages }

        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user].except(:padre_id)) # mirar remove para no actualizar el padre_id 
        #  if @user.update_attributes(params[:user]).except(:padre_id)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private 

  def set_users_empty 
    @users_empty = (User.count == 0)
  end

end
