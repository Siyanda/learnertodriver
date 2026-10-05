# frozen_string_literal: true

class Admin::PostsController < Admin::ResourcesController
  def new
    @record = Post.new(user: Current.user)
  end

  private

  def resource_class = Post

  def scope = Post.includes(:user)

  def default_sort = 'created_at desc'

  def search_attribute = :title_or_content_cont

  def index_columns = %i[title user status published_at]

  def show_attributes = %i[title user status published_at content created_at]

  def resource_params
    params.expect(post: [:title, :content, :status, :published_at, :user_id, :cover_image, { tag_ids: [] }])
  end
end
