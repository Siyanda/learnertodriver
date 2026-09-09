# frozen_string_literal: true

require 'test_helper'

class Utils::DateTimeComponentTest < ViewComponent::TestCase
  def test_renders_span_with_default_class
    component = render_inline(Utils::DateTime::Component.new(timestamp: Time.utc(2026, 9, 9, 12, 0, 0)))

    assert_equal 'date-value', component.css('span').first['class']
  end

  def test_renders_stimulus_controller_data_attribute
    component = render_inline(Utils::DateTime::Component.new(timestamp: Time.utc(2026, 9, 9, 12, 0, 0)))

    assert_equal 'utils--date-time', component.css('span').first['data-controller']
  end

  def test_renders_format_value_data_attribute
    component = render_inline(Utils::DateTime::Component.new(timestamp: Time.utc(2026, 9, 9, 12, 0, 0)))

    assert_equal 'date', component.css('span').first['data-utils--date-time-format-value']
  end

  def test_renders_timestamp_as_iso8601_for_time_objects
    timestamp = Time.utc(2026, 9, 9, 12, 0, 0)
    component = render_inline(Utils::DateTime::Component.new(timestamp: timestamp))

    assert_equal timestamp.iso8601, component.css('span').first['data-utils--date-time-time-stamp-value']
  end

  def test_renders_timestamp_as_string_for_non_time_objects
    component = render_inline(Utils::DateTime::Component.new(timestamp: '2026-09-09'))

    assert_equal '2026-09-09', component.css('span').first['data-utils--date-time-time-stamp-value']
  end

  def test_accepts_custom_format
    component = render_inline(Utils::DateTime::Component.new(timestamp: Time.utc(2026, 9, 9, 12, 0, 0),
                                                             format:    :time_ago))

    assert_equal 'time_ago', component.css('span').first['data-utils--date-time-format-value']
  end

  def test_accepts_custom_html_class
    component = render_inline(Utils::DateTime::Component.new(
                                timestamp:  Time.utc(2026, 9, 9, 12, 0, 0),
                                html_class: 'custom-class'
                              ))

    assert_equal 'custom-class', component.css('span').first['class']
  end
end
