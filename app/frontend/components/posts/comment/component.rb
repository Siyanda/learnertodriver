# frozen_string_literal: true

class Posts::Comment::Component < ApplicationViewComponent
  option :post

  def comment_count
    post.comments.count
  end

  def comments
    post.comments.includes(:user)
  end

  def comments?
    post.comments.any?
  end
end
