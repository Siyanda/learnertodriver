# frozen_string_literal: true

require 'net/http'

class BotChecks::VerifyTurnstile
  extend ::LightService::Action

  VERIFY_URL     = URI('https://challenges.cloudflare.com/turnstile/v0/siteverify').freeze
  TIMEOUT        = 5
  NETWORK_ERRORS = [
    Net::OpenTimeout, Net::ReadTimeout, SocketError, SystemCallError, OpenSSL::SSL::SSLError, JSON::ParserError
  ].freeze

  expects :turnstile_secret, :turnstile_token, :remote_ip

  def self.verified?(secret:, token:, remote_ip:)
    request = Net::HTTP::Post.new(VERIFY_URL)
    request.set_form_data(secret:, response: token, remoteip: remote_ip)

    options  = { use_ssl: true, open_timeout: TIMEOUT, read_timeout: TIMEOUT }
    response = Net::HTTP.start(VERIFY_URL.host, VERIFY_URL.port, **options) { |http| http.request(request) }

    JSON.parse(response.body).fetch('success', false)
  rescue *NETWORK_ERRORS
    false
  end

  executed do |ctx|
    next if ctx.turnstile_secret.blank?
    next if ctx.turnstile_token.present? &&
            verified?(secret: ctx.turnstile_secret, token: ctx.turnstile_token, remote_ip: ctx.remote_ip)

    ctx.fail_and_return!(I18n.t('bot_checks.failed'))
  end
end
