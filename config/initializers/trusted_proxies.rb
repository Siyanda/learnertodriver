# frozen_string_literal: true

Rails.application.config.action_dispatch.trusted_proxies =
  ActionDispatch::RemoteIp::TRUSTED_PROXIES + CloudflareRemoteIp::RANGES
