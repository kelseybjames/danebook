class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to @user
    else
      flash.now[:error] = "Failed to create user!"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user.update(whitelisted_user_params)
      flash[:success] = "Successfully updated your profile"
      redirect_to current_user
    else
      flash.now[:failure] = "Failed to update your profile"
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      sign_out
      flash[:success] = 'User destroyed'
      redirect_to root_path
    else
      flash[:error] = 'User failed to destroy'
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def whitelisted_user_params
    params.require(:user).permit(:email, 
                         :password,
                         :password_confirmation, 
                         { profile_attributes: [
                          :first_name, 
                          :last_name, 
                          :day, 
                          :month, 
                          :year, 
                          :gender] }
                         )
  end
end
