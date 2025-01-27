# frozen_string_literal: true

class PagesController < ApplicationController
  include AuthorizationConcern

  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_page_options
  before_action :set_page, only: %i[show edit update destroy]
  before_action -> { require_same_user(@page) }, only: %i[edit update destroy]

  def index
    @q = Page.ransack(params[:q])
    @pagy, @pages = pagy(@q.result, items: params[:max] || 10)
  end

  def show
    @pages = Page.all
  end

  def new
    @page = current_user.pages.build
  end

  def edit; end

  def create
    @page = current_user.pages.build(page_params)

    if @page.save
      redirect_to @page, notice: t('controllers.notices.create', model: 'Page')
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      redirect_to @page, notice: t('controllers.notices.update', model: 'Page')
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path, notice: t('controllers.notices.destroy', model: 'Page')
  end

  private

  def set_page
    @page = Page.friendly.find(params[:id]) or not_found!
  end

  def set_page_options
    @users = User.active
    @pages = Page.all
    @page_list = @pages.map { |page| [page.title, page.id] }
    @editor_list = @users.map { |user| [user.name, user.id] }
  end

  def page_params
    params.expect(page: [:title, :content, :user_id])
  end
end
