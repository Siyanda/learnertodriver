# frozen_string_literal: true

require 'test_helper'

class PurgeAbandonedSignUpsJobTest < ActiveJob::TestCase
  test 'returns how many abandoned sign-ups were purged' do
    create(:user, confirmed_at: nil, status: :pending, created_at: 8.days.ago)

    assert_equal 1, PurgeAbandonedSignUpsJob.perform_now
  end
end
