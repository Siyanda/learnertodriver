# frozen_string_literal: true

class Forms::BotCheck::Component < ApplicationViewComponent
  option :turnstile_site_key, default: -> { ENV.fetch('TURNSTILE_SITE_KEY', nil) }

  private

  def form_started_at = ::BotChecks::CheckFillTime.token

  def turnstile? = turnstile_site_key.present?

  def stimulus_data
    {
      controller:                      stimulus_id,
      "#{stimulus_id}-site-key-value": turnstile_site_key
    }
  end
end
