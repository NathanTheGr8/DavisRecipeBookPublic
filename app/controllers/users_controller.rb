class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :require_login, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #curr = @user.id
      #Session[:user_id] = user.id
      #current_user ||= User.find(session[:user_id]) if session[:user_id]
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private
    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to root_url # halts request cycle
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :avatar)

    end
end
