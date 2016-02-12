class PostsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_current_profile_user, except: [:show]

  def index

  end


  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def whitelisted_post_params
    params.require(:post).permit(:body)
  end
end
