# frozen_string_literal: true

require 'test_helper'

class BotChecks::CheckHoneypotTest < ActiveSupport::TestCase
  REMOTE_IP = '41.1.2.3'

  test 'passes when the honeypot is empty' do
    assert_predicate BotChecks::CheckHoneypot.execute(honeypot: '', remote_ip: REMOTE_IP), :success?
  end

  test 'fails when the honeypot is filled in' do
    ctx = BotChecks::CheckHoneypot.execute(honeypot: 'https://spam.example', remote_ip: REMOTE_IP)

    assert_predicate ctx, :failure?
    assert_equal I18n.t('bot_checks.failed'), ctx.message
  end

  test 'flags the ip when the honeypot is filled in' do
    BotChecks::CheckHoneypot.execute(honeypot: 'https://spam.example', remote_ip: REMOTE_IP)

    assert_predicate FlaggedIp.find_by!(ip_address: REMOTE_IP), :honeypot?
  end

  test 'does not flag the ip of a human' do
    assert_no_difference 'FlaggedIp.count' do
      BotChecks::CheckHoneypot.execute(honeypot: '', remote_ip: REMOTE_IP)
    end
  end
end
