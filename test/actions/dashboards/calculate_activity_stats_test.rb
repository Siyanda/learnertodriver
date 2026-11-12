# frozen_string_literal: true

require 'test_helper'

class Dashboards::CalculateActivityStatsTest < ActiveSupport::TestCase
  test 'compares the last 30 days with the 30 days before' do
    travel_to(45.days.ago) { create(:comment) }
    create_list(:comment, 3)

    trend = Dashboards::CalculateActivityStats.execute.activity.fetch(:comments)

    assert_equal 3,   trend.current
    assert_equal 1,   trend.previous
    assert_equal 200, trend.change
  end

  test 'counts completed evaluations by completion date' do
    create(:evaluation, :completed, created_at: 90.days.ago)
    create(:evaluation, :started)

    trend = Dashboards::CalculateActivityStats.execute.activity.fetch(:evaluations_completed)

    assert_equal 1, trend.current
  end

  test 'has no change when the previous window is empty' do
    create(:comment)

    assert_nil Dashboards::CalculateActivityStats.execute.activity.fetch(:comments).change
  end
end
