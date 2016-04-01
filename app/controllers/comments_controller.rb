class CommentsController < ApplicationController
  before_action :set_parent, only: [:index, :create, :edit, :update]

  def index
    @comments = @parent.comments.order('created_at DESC')
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(whitelisted_comment_params)
    @comment[:author_id] = current_user.id
    respond_to do |format|
      if @comment.save
        format.js {}
        format.html { redirect_to request.referrer }
      else
        format.js {}
        format.html { redirect_to request.referrer }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.delete
        format.js {}
      else
        format.js {}
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
