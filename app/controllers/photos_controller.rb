class PhotosController < ApplicationController
  before_action :set_user
  before_action :require_current_user, only: [:create, :destroy]
  before_action :require_user_friend, only: [:show]

  def index
    @photos = @user.photos.order('created_at DESC')
    @photo = Photo.new
  end

  def create
    @photo = @user.photos.build(whitelisted_photo_params)
    if @photo.save
      flash[:success] = 'Photo uploaded'
      redirect_to user_photos_path(@user)
    else
      flash[:error] = 'Photo failed to upload'
      redirect_to user_photos_path(@user)
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = 'Photo destroyed'
    else
      flash[:error] = 'Photo failed to destroy'
    end
    redirect_to user_photos_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def require_user_friend
    unless current_user.friends.include?(@user) || (current_user == @user)
      flash[:error] = 'Not authorized'
      redirect_to request.referrer
    end
  end

  def whitelisted_photo_params
    params.require(:photo).permit(:image)
  end
end
