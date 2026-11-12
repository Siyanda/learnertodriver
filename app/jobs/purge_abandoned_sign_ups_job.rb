# frozen_string_literal: true

class PurgeAbandonedSignUpsJob < ApplicationJob
  queue_as :default

  def perform
    ::Users::PurgeAbandonedSignUps.execute.purged_count
  end
end
