# frozen_string_literal: true

class Utils::InlineSvg::Component < ApplicationViewComponent
  option :path

  def svg_content
    file = Rails.root.join('app/assets/images/svg', path).cleanpath
    raise ArgumentError, "SVG not found: #{path}" unless file.exist?

    file.read
  end
end
