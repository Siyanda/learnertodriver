# frozen_string_literal: true

class BotChecks::CheckFillTime
  extend ::LightService::Action

  MIN_FILL_TIME = 3.seconds
  MAX_FORM_AGE  = 1.day

  expects :form_started_at

  def self.token(started_at: Time.current) = verifier.generate(started_at.to_i, expires_in: MAX_FORM_AGE)

  def self.verifier = Rails.application.message_verifier(:bot_checks_fill_time)

  executed do |ctx|
    started_at = verifier.verified(ctx.form_started_at.to_s)
    next if started_at.is_a?(Integer) && Time.current.to_i - started_at >= MIN_FILL_TIME.to_i

    ctx.fail_and_return!(I18n.t('bot_checks.failed'))
  end
end
