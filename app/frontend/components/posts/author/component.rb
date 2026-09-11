# frozen_string_literal: true

class Posts::Author::Component < ApplicationViewComponent
  option :post

  def author_name
    post.user.name
  end
end
