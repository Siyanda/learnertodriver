# frozen_string_literal: true

require 'test_helper'

class Posts::PreviewCard::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(post: create(:post))

    render_inline(component)

    assert_selector '.basic-border.block'
  end

  private

  def build_component(**)
    Posts::PreviewCard::Component.new(**)
  end
end
