# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Learnertodriver # rubocop:disable Style/ClassAndModuleChildren
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = 'Africa/Johannesburg'
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
