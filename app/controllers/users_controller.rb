class UsersController < ApplicationController

  before_filter :set_users_empty, :only=>[:index, :create, :update] #aunque solo lo utilizo en 'create' pero me vale de buen ejemplo
  
  def index
    @users = User.order(:nombre).page params[:page]
  end

  def show
    @user = User.includes(:padre, :hijos, :contacts).find(params[:id]) #de ésta forma sólo con 1 query me traigo los contacts, hijos y padre
  end

  def new
    @user = User.new(:padre_id => params[:padre_id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    father = User.find(params[:user][:padre_id]) rescue nil # ojo aqui q el parametro :padre_id viene asociado a un :user
                                                            # x eso se recoge con "params[:user][:padre_id]"
    if father.nil? && !@users_empty  # si el padre no existe habiendo users, no crear user xq nos están metiendo un padre_id malo
      redirect_to users_path, notice: " His father does not exist!!!" # y me manda a lista d users para q elija otro user para crear un hijo # redirect_to users_path, notice: "His father does not exist!!!" and return 
    elsif !father.nil? && @users_empty # o si habiendo padre no hay users tampoco crear
      redirect_to users_path, notice: " His father exists, but users list is empty. Wrong way!!!"
    else
      # se crea el user xq... o bien existen el padre y hay users, o bien ni padre ni users y lo q se crea es el superUser
      @user = User.new(params[:user])
  
      if @user.save
        redirect_to user_path(@user.id), notice: ' User was successfully created.' 
      else
        render action: "new"  # me renderiza al new con los valores q ya estén tras el _form
      end
    end
  end # end del create

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user].except(:padre_id)) # except es para q no me cambien el padre_id del user
      redirect_to @user, notice: ' User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    # compruebo q no tenga hijos el user
    children_empty = User.where(padre_id: @user.id).count == 0 #será true si es = 0, osea si no tiene hijos
    
    if children_empty #si no tiene hijos se borra el user y notifica
      @user.destroy
      message = ' User was successfully deleted.'
    else  #si no es así, notificamos sin borrar
      message = ' This user has children, you can not delete him'      
    end
    redirect_to users_path, notice: message 
  end

  private 

  def set_users_empty 
    @users_empty = (User.count == 0)
  end
end