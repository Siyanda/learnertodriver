# frozen_string_literal: true

require 'test_helper'

class Posts::Author::ComponentTest < ViewComponent::TestCase
  def test_renders_author_name
    post = create(:post)

    render_inline(Posts::Author::Component.new(post: post))

    assert_selector '.post-author-content .bold', text: post.user.name
  end
end
