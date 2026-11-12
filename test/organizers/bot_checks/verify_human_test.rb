# frozen_string_literal: true

require 'test_helper'

class BotChecks::VerifyHumanTest < ActiveSupport::TestCase
  setup do
    @form_started_at = BotChecks::CheckFillTime.token(started_at: 10.seconds.ago)
  end

  test 'passes a human submission' do
    assert_predicate verify(honeypot: nil), :success?
  end

  test 'stops at the first failed check' do
    result = verify(honeypot: 'spam')

    assert_predicate result, :failure?
    assert_equal I18n.t('bot_checks.failed'), result.message
  end

  private

  def verify(honeypot:)
    BotChecks::VerifyHuman.call(honeypot:, form_started_at: @form_started_at, turnstile_token: nil,
                                remote_ip: '41.1.2.3', turnstile_secret: nil)
  end
end
