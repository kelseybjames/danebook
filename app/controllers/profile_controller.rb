class ProfileController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def whitelisted_profile_params
    params.require(:profile).permit(:quote,
                                    :about_me)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
