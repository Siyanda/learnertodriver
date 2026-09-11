# frozen_string_literal: true

require 'test_helper'

class User::Avatar::ComponentTest < ViewComponent::TestCase
  def test_renders
    component = build_component(user: create(:user))

    render_inline(component)

    assert_selector 'img.avatar'
  end

  private

  def build_component(**)
    User::Avatar::Component.new(**)
  end
end
