class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index
    # index
  end

  def show
    # show
  end

  def edit
    # show
  end

  def update
    # show
  end

  private

  def set_page
    @page = Page.friendly.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :template)
  end
end
