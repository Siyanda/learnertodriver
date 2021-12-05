require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Learnertodriver
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.time_zone = "Africa/Johannesburg"
    config.active_job.queue_adapter = :sidekiq
    # config.eager_load_paths << Rails.root.join("extras")  end
  end
end
