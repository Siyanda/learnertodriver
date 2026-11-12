# frozen_string_literal: true

require 'test_helper'

class BotChecks::CheckFillTimeTest < ActiveSupport::TestCase
  test 'passes when the form took a human amount of time' do
    token = BotChecks::CheckFillTime.token(started_at: 10.seconds.ago)

    assert_predicate BotChecks::CheckFillTime.execute(form_started_at: token), :success?
  end

  test 'fails when the form was submitted too quickly' do
    token = BotChecks::CheckFillTime.token

    assert_predicate BotChecks::CheckFillTime.execute(form_started_at: token), :failure?
  end

  test 'fails when the token is missing' do
    assert_predicate BotChecks::CheckFillTime.execute(form_started_at: nil), :failure?
  end

  test 'fails when the token is tampered with' do
    assert_predicate BotChecks::CheckFillTime.execute(form_started_at: 1.minute.ago.to_i.to_s), :failure?
  end

  test 'fails when the form is older than a day' do
    token = BotChecks::CheckFillTime.token(started_at: 10.seconds.ago)

    travel_to(2.days.from_now) { assert_predicate BotChecks::CheckFillTime.execute(form_started_at: token), :failure? }
  end
end
