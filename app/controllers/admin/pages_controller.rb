# frozen_string_literal: true

class Admin::PagesController < Admin::ResourcesController
  def new
    @record = Page.new(user: Current.user)
  end

  private

  def resource_class = Page

  def scope = Page.includes(:user, :parent)

  def default_sort = 'created_at desc'

  def search_attribute = :title_or_content_cont

  def index_columns = %i[title parent user status published_at]

  def show_attributes = %i[title parent user status published_at content created_at]

  def resource_params
    params.expect(page: %i[title content status published_at user_id parent_id])
  end
end
