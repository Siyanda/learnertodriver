class PhotosController < ApplicationController
  def create
    Photo.create(photo_params)

  end

  def new
    
  end

  def show
  
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
