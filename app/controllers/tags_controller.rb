class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_tag, only: %i[show edit update destroy]

  def new
    @tag = @tagable.tags.new
  end

  def create
    @tag = @tagable.tags.new tag_params
    @tagable.save
    redirect_to @tagable, notice: 'item was successfully tagged'
  end

  private

  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:content)
  end
end
