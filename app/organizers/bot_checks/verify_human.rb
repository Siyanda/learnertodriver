# frozen_string_literal: true

class BotChecks::VerifyHuman
  extend ::LightService::Organizer

  def self.call(honeypot:, form_started_at:, turnstile_token:, remote_ip:,
                turnstile_secret: ENV.fetch('TURNSTILE_SECRET_KEY', nil))
    with(honeypot:, form_started_at:, turnstile_token:, remote_ip:, turnstile_secret:).reduce(actions)
  end

  def self.actions
    [
      BotChecks::CheckHoneypot,
      BotChecks::CheckFillTime,
      BotChecks::VerifyTurnstile,
    ]
  end
end
