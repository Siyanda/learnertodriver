class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def new
    @tag = @tagable.tags.new
  end

  def create
    @tag = @tagable.tags.new tag_params
    @tagable.save
    redirect_to @tagable, notice: "item was successfully tagged"
  end

  private

    def tag_params
      params.require(:tag).permit( :content)
    end
end
