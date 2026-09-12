# frozen_string_literal: true

require 'test_helper'

class Quiz::PreviewCard::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(quiz: create(:quiz))

    render_inline(component)

    assert_selector '.card'
  end

  private

  def build_component(**)
    Quiz::PreviewCard::Component.new(**)
  end
end
