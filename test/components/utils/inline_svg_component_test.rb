# frozen_string_literal: true

require 'test_helper'

class Utils::InlineSvgComponentTest < ViewComponent::TestCase
  def test_renders_svg_content
    svg = render_inline(Utils::InlineSvg::Component.new(path: 'icons/address.svg'))

    assert_includes svg.to_html, '<svg'
    assert_includes svg.to_html, 'xmlns="http://www.w3.org/2000/svg"'
  end

  def test_raises_when_svg_not_found
    error = assert_raises(ArgumentError) do
      render_inline(Utils::InlineSvg::Component.new(path: 'missing.svg'))
    end

    assert_equal 'SVG not found: missing.svg', error.message
  end

  def test_raises_when_path_escapes_svg_directory
    assert_raises(ArgumentError) do
      render_inline(Utils::InlineSvg::Component.new(path: '../../config/database.yml'))
    end
  end
end
