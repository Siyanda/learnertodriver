# frozen_string_literal: true

class Interceptors::DailyEmailLimit
  DEFAULT_LIMIT = 300
  CACHE_KEY     = 'daily-email-count'

  attr_reader :limit, :store

  def self.delivering_email(message) = new.delivering_email(message)

  def initialize(limit: ENV.fetch('DAILY_EMAIL_LIMIT', DEFAULT_LIMIT).to_i, store: Rails.cache)
    @limit = limit
    @store = store
  end

  def delivering_email(message)
    return unless message.perform_deliveries

    sent_today = store.increment("#{CACHE_KEY}:#{Date.current.iso8601}", 1, expires_in: 1.day)
    return if sent_today.nil? || sent_today <= limit

    message.perform_deliveries = false
    Rails.logger.warn("Daily email limit of #{limit} reached, skipped: #{message.subject}")
  end
end
