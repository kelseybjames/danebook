class PostsController < ApplicationController
  before_action :set_user, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :require_current_profile_user, except: [:show, :index]

  def index
    @posts = @user.posts.order('id DESC')
    @post = Post.new
  end

  def create
    @post = @user.posts.build(whitelisted_post_params)
    if @post.save
      flash[:success] = 'Post created'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Post failed to create'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = 'Post deleted'
      redirect_to user_posts_path(@user)
    else
      flash[:error] = 'Post failed to delete'
      redirect_to user_posts_path(@user)
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
