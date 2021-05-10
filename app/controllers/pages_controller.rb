class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_page_options
  before_action :set_page, only: %i[show edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @pages = Page.all
  end

  def show; end

  def new
    @page = current_user.pages.build
  end

  def edit
    #
  end

  def create
    @page = current_user.pages.build(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_path, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def require_same_user
    if current_user != @page.editor
      flash[:danger] = 'Not authorized to edit this page'
      redirect_to root_path
    end
  end

  def set_page
    @page = Page.friendly.find(params[:id])
  end

  def set_page_options
    @pages = Page.all.map { |page| [page.title, page.id ] }
    @editors = User.all.map { |user| [user.name, user.id ] }
  end

  def page_params
    params.require(:page).permit(:title, :content, :author_id)
  end
end
