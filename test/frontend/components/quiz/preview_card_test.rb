# frozen_string_literal: true

require 'test_helper'

class Quiz::PreviewCard::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component

    render_inline(component)

    assert_selector 'div'
  end

  private

  def build_component(**)
    Quiz::PreviewCard::Component.new(**)
  end
end
