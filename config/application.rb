# frozen_string_literal: true

require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Learnertodriver
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.time_zone = "Africa/Johannesburg"
    config.active_job.queue_adapter = :sidekiq
  end
end
