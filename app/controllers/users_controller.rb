class UsersController < ApplicationController

  enable_sync
  
  def index
   @users = User.without_user(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def status
    @user = User.find(params[:id])
    respond_to do |format|
      format.json { render :json =>  @user.to_json(:only => [:id, :status], :methods => [:full_name]) }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    @path = URI(request.referer).path
    if @path == "/users/" + current_user.id.to_s + "/edit"
      @path = users_path
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @path}
        format.json { head :no_content }
      else
        format.html { redirect_to users_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def new
    @user = User.new

    respond_to do |format|
        format.html { redirect_to users_path }
        format.json { head :no_content }
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
        format.html { redirect_to users_path }
        format.json { head :no_content }
    end
  end  
  
 end
