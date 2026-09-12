# frozen_string_literal: true

class Posts::PreviewCard::Component < ApplicationViewComponent
  with_collection_parameter :post

  option :post

  delegate :title, to: :post

  def excerpt
    post.content
  end

  def comment_count
    post.comments.size
  end

  def view_count
    post.comments.size
  end

  def post_age
    post.created_at
  end
end
