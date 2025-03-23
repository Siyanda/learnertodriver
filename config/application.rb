# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Learnertodriver
  class Application < Rails::Application
    config.load_defaults 8.0
    config.time_zone = 'Africa/Johannesburg'
  end
end
