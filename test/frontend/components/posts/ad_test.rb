# frozen_string_literal: true

require 'test_helper'

class Posts::Ad::ComponentTest < ViewComponent::TestCase
  def test_renders_ad
    render_inline(Posts::Ad::Component.new(ad: 'Sponsored'))

    assert_selector '.sub-heading', text: 'Sponsored'
  end
end
