# frozen_string_literal: true

class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_tag, only: %i[show edit update destroy]

  def show; end

  def new
    @tag = @tagable.tags.new
  end

  def edit; end

  def create
    @tag = @tagable.tags.new tag_params
    @tagable.save
  end

  def update; end

  def destroy; end

  private

  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:content)
  end
end
