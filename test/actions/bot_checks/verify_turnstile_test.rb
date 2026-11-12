# frozen_string_literal: true

require 'test_helper'

class BotChecks::VerifyTurnstileTest < ActiveSupport::TestCase
  test 'skips verification when Turnstile is not configured' do
    ctx = BotChecks::VerifyTurnstile.execute(turnstile_secret: nil, turnstile_token: nil, remote_ip: '41.1.2.3')

    assert_predicate ctx, :success?
  end

  test 'fails when the Turnstile token is missing' do
    ctx = BotChecks::VerifyTurnstile.execute(turnstile_secret: 'secret', turnstile_token: '', remote_ip: '41.1.2.3')

    assert_predicate ctx, :failure?
    assert_equal I18n.t('bot_checks.failed'), ctx.message
  end
end
