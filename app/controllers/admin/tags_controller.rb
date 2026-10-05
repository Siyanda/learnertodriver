# frozen_string_literal: true

class Admin::TagsController < Admin::ResourcesController
  private

  def resource_class = Tag

  def search_attribute = :title_cont

  def index_columns = %i[title status]

  def show_attributes = %i[title slug status]

  def resource_params
    params.expect(tag: %i[title status])
  end
end
