# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

require_relative '../lib/middleware/cloudflare_remote_ip'

module Learnertodriver # rubocop:disable Style/ClassAndModuleChildren
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = 'Africa/Johannesburg'
    config.autoload_lib(ignore: %w[assets tasks generators middleware])

    config.middleware.insert_after ActionDispatch::RemoteIp, CloudflareRemoteIp

    config.autoload_paths                << Rails.root.join('app/frontend/components')
    config.autoload_paths                << Rails.root.join('app/frontend/components/concerns')
    config.view_component.previews.paths << Rails.root.join('app/frontend/components')

    config.view_component.previews.controller     = 'PreviewController'
    config.view_component.previews.default_layout = 'component_preview'

    config.action_mailer.interceptors = %w[Interceptors::SuppressedRecipients Interceptors::DailyEmailLimit]
  end
end
