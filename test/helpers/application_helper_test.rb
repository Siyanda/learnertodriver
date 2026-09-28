# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def test_component_renders_a_component_by_path
    assert_dom_equal(Utils::InlineSvg::Component.new(path: 'icons/user.svg').render_in(view),
                     component('utils/inline_svg', path: 'icons/user.svg'))
  end

  def test_collection_component_renders_a_collection
    posts = create_list(:post, 2)

    assert_dom_equal(posts.map { |post| Posts::PreviewCard::Component.new(post:).render_in(view) }.join,
                     collection_component('posts/preview_card', posts))
  end
end
