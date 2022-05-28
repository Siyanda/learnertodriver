# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show edit update destroy]

  def create
    Photo.create(photo_params)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:image)
  end
end
