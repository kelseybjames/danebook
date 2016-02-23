class PhotosController < ApplicationController
  before_action :set_user

  def index
    @photos = @user.photos.order('created_at DESC')
    @photo = Photo.new
  end

  def new
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

  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def whitelisted_photo_params
    params.require(:photo).permit(:image)
  end
end
