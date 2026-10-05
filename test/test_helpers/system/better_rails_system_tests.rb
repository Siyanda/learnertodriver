# frozen_string_literal: true

module BetterRailsSystemTests
  # Overrides ActionDispatch's private, argument-less #absolute_image_path,
  # which reads the screenshot name from #image_name.
  def absolute_image_path
    Rails.root.join("#{Capybara.save_path}/screenshots/#{image_name}.png")
  end

  def take_screenshot
    return super unless Capybara.last_used_session

    Capybara.using_session(Capybara.last_used_session) { super }
  end
end
