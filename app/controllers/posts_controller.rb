class PostsController < ApplicationController
  before_action :set_user, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :require_current_profile_user, except: [:show, :index]

  def index
    @posts = @user.posts.order('id DESC')
    @post = Post.new
  end

  def create
    @post = @user.posts.build(whitelisted_post_params)
    respond_to do |format|
      if @post.save
        format.js {}
        format.html { redirect_to request.referrer }
      else
        format.js {}
        format.html { redirect_to request.referrer }
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.destroy
        format.js {}
      else
        format.js {}
      end
    end
  end
  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def whitelisted_post_params
    params.require(:post).permit(:body)
  end
end
