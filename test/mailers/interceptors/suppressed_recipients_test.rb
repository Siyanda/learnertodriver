# frozen_string_literal: true

require 'test_helper'

class Interceptors::SuppressedRecipientsTest < ActiveSupport::TestCase
  setup do
    create(:email_suppression, email_address: 'gone@example.com')
  end

  test 'does not deliver to a suppressed address' do
    message = Mail.new(to: 'Gone@example.com')

    Interceptors::SuppressedRecipients.delivering_email(message)

    assert_not message.perform_deliveries
  end

  test 'drops suppressed addresses but still delivers to the rest' do
    message = Mail.new(to: %w[gone@example.com learner@example.com])

    Interceptors::SuppressedRecipients.delivering_email(message)

    assert_equal %w[learner@example.com], message.to
    assert_predicate message, :perform_deliveries
  end

  test 'skipped emails do not count toward the daily limit' do
    message = Mail.new(to: 'gone@example.com')
    limit   = Interceptors::DailyEmailLimit.new(limit: 1, store: ActiveSupport::Cache::MemoryStore.new)

    Interceptors::SuppressedRecipients.delivering_email(message)
    limit.delivering_email(message)

    assert_equal 1, limit.store.increment("#{Interceptors::DailyEmailLimit::CACHE_KEY}:#{Date.current.iso8601}")
  end
end
