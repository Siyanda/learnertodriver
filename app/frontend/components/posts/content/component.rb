# frozen_string_literal: true

class Posts::Content::Component < ApplicationViewComponent
  option :post

  delegate :title, to: :post

  def body
    from_markdown(liquidize(post.content))
  end
end
