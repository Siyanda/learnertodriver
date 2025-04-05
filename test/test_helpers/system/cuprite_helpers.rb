# frozen_string_literal: true

module CupriteHelpers
  def pause
    page.driver.pause
  end

  def debug(*)
    page.driver.debug(*)
  end
end
