class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :require_current_user, only: [:update, :destroy, :newsfeed]

  def index
    @users = User.search(params[:query])
  end

  def new
    if current_user
      redirect_to user_posts_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      User.delay.send_welcome_email(@user.id)
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = "Failed to create user!"
      render :new
    end
  end

  def show
  end

  def update
    # TODO: Fix photos show view with set avatar links
    @user = User.find(params[:id])
    if @user.update(whitelisted_user_params)
      flash[:success] = "Updated user!"
      redirect_to user_posts_path(@user)
    else
      flash[:error] = "Failed to update user!"
      redirect_to request.referrer
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

  def newsfeed
    @user = User.find(params[:user_id])
    @newsfeed = @user.newsfeed
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def whitelisted_user_params
    params.require(:user).permit(:email, 
                         :password,
                         :password_confirmation,
                         :avatar_id,
                         :cover_photo_id,
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
