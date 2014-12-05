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
    @father_user = User.find(@user.padre_id) rescue nil

    if (@father_user == nil) #no hay user padre
      @noFather = true
    else #hay user
      @noFather = false
    end

    @userSons = User.where(padre_id: @user.id) #cojo los hijos de ese user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new(:padre_id => params[:padre_id]) #TODO: comprobar al crear superUser q no manda padre_id

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
    #TODO: comprobar q el padre exite
    father = User.find(params[:user][:padre_id]) rescue nil # ojo aqui q el parametro :padre_id viene asociado a un :user
                                                            # x eso se recoge con "params[:user][:padre_id]"


    if (father.nil? & !(set_users_empty)) # si el padre no existe no crear user xq nos están metiendo un padre_id malo
                                          # y también mirar q User no esté vacío, xq si está vacío es q no hay users
                                          # y debería dejar entonces pasar al "else" para crear un user-superUser
      redirect_to users_path, notice: "His father does not exist!!!"
      #render action: "index" #  
    else
      @user = User.new(params[:user])
  
      respond_to do |format|
        #debugger
        if @user.save
          format.html { redirect_to user_path(@user.id), notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          ###format.html { redirect_to users_path, notice: @user.errors.messages } #ir a users/index
          format.html { render action: "new" } #me renderiza al new con los valores q ya estén tras el _form
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
##################################################################################################################
# Otra forma de hacerlo, interesante el "and return" q finaliza las acciones dentro del create y así no continua
#      if father.nil? # el padre no existe
#        redirect_to users_path, notice: "His father does not exist!!!" and return
#        #render action: "index" #  
#      else
#        @user = User.new(params[:user])
#  
#      end
#      respond_to do |format|
#        #debugger
#        if @user.save
#          format.html { redirect_to user_path(@user.id), notice: 'User was successfully created.' }
#          format.json { render json: @user, status: :created, location: @user }
#        else
#          ###format.html { redirect_to users_path, notice: @user.errors.messages } #ir a users/index
#          format.html { render action: "new" } #me renderiza al new con los valores q ya estén tras el _form
#          format.json { render json: @user.errors, status: :unprocessable_entity }
#        end
#      end
###################################################################################################################

  end # end del create

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user].except(:padre_id)) 
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
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private 

  def set_users_empty 
    @users_empty = (User.count == 0)
  end

end
