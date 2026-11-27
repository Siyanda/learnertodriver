# frozen_string_literal: true

class BotChecks::CheckHoneypot
  extend ::LightService::Action

  expects :honeypot, :remote_ip

  executed do |ctx|
    next if ctx.honeypot.blank?

    ::FlaggedIp.flag(ip_address: ctx.remote_ip, reason: :honeypot)
    ctx.fail_and_return!(I18n.t('bot_checks.failed'))
  end
end
