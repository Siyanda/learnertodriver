# frozen_string_literal: true

class BotChecks::CheckHoneypot
  extend ::LightService::Action

  expects :honeypot

  executed do |ctx|
    next if ctx.honeypot.blank?

    ctx.fail_and_return!(I18n.t('bot_checks.failed'))
  end
end
