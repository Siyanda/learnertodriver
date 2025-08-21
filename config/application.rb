# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Learnertodriver # rubocop:disable Style/ClassAndModuleChildren
  class Application < Rails::Application
    # Provides an HTML generator for displaying errors that come from Active Model
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      raw Nokogiri::HTML.fragment(html_tag).child.add_class("is-invalid")
    end
    config.load_defaults 7.0
    config.time_zone = 'Africa/Johannesburg'
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
