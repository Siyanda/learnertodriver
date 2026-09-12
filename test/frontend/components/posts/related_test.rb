# frozen_string_literal: true

require 'test_helper'

class Posts::Related::ComponentTest < ViewComponent::TestCase
  def test_renders_ad
    post = create(:post)

    render_inline(Posts::Related::Component.new(post:))

    assert_selector '.sub-heading', text: 'Related Posts'
  end
end
