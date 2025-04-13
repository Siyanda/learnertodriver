# frozen_string_literal: true

class TestSolidQueueJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info "✅ Solid Queue is working! Args: #{args.inspect}"
    puts "✅ Solid Queue is working! Args: #{args.inspect}"
  end
end
