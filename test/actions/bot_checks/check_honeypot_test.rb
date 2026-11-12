# frozen_string_literal: true

require 'test_helper'

class BotChecks::CheckHoneypotTest < ActiveSupport::TestCase
  test 'passes when the honeypot is empty' do
    assert_predicate BotChecks::CheckHoneypot.execute(honeypot: ''), :success?
  end

  test 'fails when the honeypot is filled in' do
    ctx = BotChecks::CheckHoneypot.execute(honeypot: 'https://spam.example')

    assert_predicate ctx, :failure?
    assert_equal I18n.t('bot_checks.failed'), ctx.message
  end
end
