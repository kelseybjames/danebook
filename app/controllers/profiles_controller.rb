class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_current_profile_user, except: [:show]

  def create
  end

  def show
    @profile = @user.profile
  end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = @user.profile
    if @profile.update(whitelisted_profile_params)
      flash[:success] = 'Profile updated'
      redirect_to user_profile_path(@user.id, @profile)
    else

    end
  end

  private

  def whitelisted_profile_params
    params.require(:profile).permit(:quote,
                                    :about_me,
                                    :first_name,
                                    :last_name,
                                    :day,
                                    :month,
                                    :year,
                                    :gender)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
