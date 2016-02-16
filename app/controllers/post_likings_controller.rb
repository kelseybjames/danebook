class PostLikingsController < ApplicationController
  before_action :require_login

  def create
    @like = PostLiking.new(whitelisted_liking_params)
    if @like.save
      flash[:success] = 'Post liked'
    else
      flash[:error] = 'Post like failed'
    end
    redirect_to request.referrer
  end

  def destroy
    @like = PostLiking.find(params[:id])
    if @like.destroy
      flash[:success] = 'Post unliked'
    else
      flash[:error] = 'Post unlike failed'
    end
    redirect_to request.referrer
  end

  private

  def whitelisted_liking_params
    params.permit(:user_id, :post_id)
  end
end
