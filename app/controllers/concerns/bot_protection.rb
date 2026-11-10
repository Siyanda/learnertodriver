# frozen_string_literal: true

module BotProtection
  extend ActiveSupport::Concern

  HONEYPOT_FIELD  = :website
  FILL_TIME_FIELD = :form_started_at
  TURNSTILE_FIELD = :'cf-turnstile-response'

  class_methods do
    def protect_from_bots(with:, **)
      before_action(**) do
        result = ::BotChecks::VerifyHuman.call(
          honeypot:        params[HONEYPOT_FIELD],
          form_started_at: params[FILL_TIME_FIELD],
          turnstile_token: params[TURNSTILE_FIELD],
          remote_ip:       request.remote_ip
        )

        instance_exec(result.message, &with) if result.failure?
      end
    end
  end
end
