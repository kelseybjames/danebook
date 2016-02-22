class LikesController < ApplicationController
  before_action :require_login
  before_action :set_post

  def create
    @like = Like.new(whitelisted_liking_params)
    @like[:user_id] = current_user.id
    @like[:likeable_id] = @post.id
    @like[:likeable_type] = 'Post'
    if @like.save
      flash[:success] = 'Post liked'
    else
      flash[:error] = 'Post like failed'
    end
    redirect_to request.referrer
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:success] = 'Post unliked'
    else
      flash[:error] = 'Post unlike failed'
    end
    redirect_to request.referrer
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def whitelisted_liking_params
    params.permit(:likeable_id, :likeable_type)
  end
end
