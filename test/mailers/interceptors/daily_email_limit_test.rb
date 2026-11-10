# frozen_string_literal: true

require 'test_helper'

class Interceptors::DailyEmailLimitTest < ActiveSupport::TestCase
  setup do
    @interceptor = Interceptors::DailyEmailLimit.new(limit: 1, store: ActiveSupport::Cache::MemoryStore.new)
    @message     = Mail.new(to: 'learner@example.com', subject: 'Confirm your email address')
  end

  test 'delivers emails while under the daily limit' do
    @interceptor.delivering_email(@message)

    assert_predicate @message, :perform_deliveries
  end

  test 'stops delivering once the daily limit is reached' do
    @interceptor.delivering_email(Mail.new)
    @interceptor.delivering_email(@message)

    assert_not @message.perform_deliveries
  end

  test 'resets the count the next day' do
    @interceptor.delivering_email(Mail.new)

    travel_to(1.day.from_now) { @interceptor.delivering_email(@message) }

    assert_predicate @message, :perform_deliveries
  end
end
