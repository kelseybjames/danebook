class CommentsController < ApplicationController
  before_action :set_parent, only: [:index, :create, :edit, :update]

  def index
    @comments = @parent.comments.order('created_at DESC')
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(whitelisted_comment_params)
    @comment[:author_id] = current_user.id
    # byebug
    respond_to do |format|
      if @comment.save
        format.js {}
        flash.now[:success] = 'Commented'
      else
        format.js {}
        flash.now[:error] = 'Failed to comment'
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.delete
        format.js {}
        flash.now[:success] = 'Destroyed'
      else
        format.js {}
        flash.now[:error] = 'Failed to destroy'
      end
    end
  end

  private

  def set_parent
    @parent = extract_commentable.find(params[id_type])
  end

  def extract_commentable
    params[:commentable].constantize
  end

  def id_type
    type = params[:commentable]
    (type.downcase + '_id').to_sym
  end

  def whitelisted_comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
