# frozen_string_literal: true

class Posts::Comment::Component < ApplicationViewComponent
  option :post

  def comment_count
    post.comments.visible.count
  end

  def comments
    post.comments.visible.includes(:user)
  end

  def comments?
    post.comments.visible.any?
  end
end
