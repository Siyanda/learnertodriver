# frozen_string_literal: true

class Admin::CommentsController < Admin::ResourcesController
  def new
    @record = Comment.new(user: Current.user)
  end

  private

  def resource_class = Comment

  def scope = Comment.includes(:user, :post)

  def default_sort = 'created_at desc'

  def search_attribute = :content_cont

  def index_columns = %i[content post user status created_at]

  def show_attributes = %i[content post user status created_at]

  def resource_params
    params.expect(comment: %i[content status post_id user_id])
  end
end
