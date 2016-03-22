class LikesController < ApplicationController
  before_action :require_login
  before_action :set_parent

  def create
    @like = Like.new(whitelisted_liking_params)
    @like[:user_id] = current_user.id
    @like[:likeable_id] = @parent.id
    @like[:likeable_type] = @parent.class.to_s
    respond_to do |format|
      if @like.save
        format.js {}
      else
        format.js {}
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:success] = "#{@parent.class.to_s} unliked"
    else
      flash[:error] = "#{@parent.class.to_s} unlike failed"
    end
    redirect_to request.referrer
  end

  private

  def set_parent
    @parent = extract_likeable.find(params[id_type])
  end

  def extract_likeable
    params[:likeable].constantize
  end

  def id_type
    type = params[:likeable]
    (type.downcase + '_id').to_sym
  end

  def whitelisted_liking_params
    params.permit(:likeable_id, :likeable_type)
  end
end
