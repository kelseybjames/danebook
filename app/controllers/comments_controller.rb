class CommentsController < ApplicationController
  before_action :set_post, only: [:index, :edit, :update]

  def index
    @comments = @post.comments.order('created_at DESC')
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(whitelisted_comment_params)
    @comment[:author_id] = current_user.id
    if @comment.save
      flash[:success] = 'Commented'
    else
      flash[:error] = 'Failed to comment'
    end
    redirect_to request.referrer
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.delete
      flash[:success] = 'Comment deleted'
    else
      flash[:error] = 'Failed to delete comment'
    end
    redirect_to request.referrer
  end

  private

  def set_post
    @post = Post.find(params[:commentable_id])
  end

  def whitelisted_comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
