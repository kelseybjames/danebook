class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :require_current_user, only: [:destroy]

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
      User.delay.send_welcome_email(@user.id)
      flash[:success] = "Created new user!"
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = "Failed to create user!"
      render :new
    end
  end

  def show
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
                          :quote,
                          :about_me,
                          :first_name, 
                          :last_name, 
                          :day, 
                          :month, 
                          :year, 
                          :gender] }
                         )
  end
end
