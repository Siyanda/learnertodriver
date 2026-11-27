# frozen_string_literal: true

require 'test_helper'

class BotChecks::CheckFillTimeTest < ActiveSupport::TestCase
  REMOTE_IP = '41.1.2.3'

  test 'passes when the form took a human amount of time' do
    token = BotChecks::CheckFillTime.token(started_at: 10.seconds.ago)

    assert_predicate check(token), :success?
  end

  test 'fails when the form was submitted too quickly' do
    assert_predicate check(BotChecks::CheckFillTime.token), :failure?
  end

  test 'flags the ip when the form was submitted too quickly' do
    check(BotChecks::CheckFillTime.token)

    assert_predicate FlaggedIp.find_by!(ip_address: REMOTE_IP), :too_fast?
  end

  test 'fails when the token is missing' do
    assert_predicate check(nil), :failure?
  end

  test 'fails when the token is tampered with' do
    assert_predicate check(1.minute.ago.to_i.to_s), :failure?
  end

  test 'fails without flagging the ip when the form is older than a day' do
    token = BotChecks::CheckFillTime.token(started_at: 10.seconds.ago)

    travel_to(2.days.from_now) { assert_predicate check(token), :failure? }
    assert_empty FlaggedIp.all
  end

  private

  def check(token) = BotChecks::CheckFillTime.execute(form_started_at: token, remote_ip: REMOTE_IP)
end
