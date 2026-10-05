# frozen_string_literal: true

require 'test_helper'

class Utils::ScoreMeter::ComponentTest < ViewComponent::TestCase
  def test_renders_meter_and_value
    render_inline(Utils::ScoreMeter::Component.new(score: 80))

    assert_selector 'meter[value="80"][max="100"]'
    assert_selector '.score-value', text: '80%'
  end

  def test_renders_placeholder_without_score
    render_inline(Utils::ScoreMeter::Component.new(score: nil))

    assert_no_selector 'meter'
    assert_text '—'
  end
end
