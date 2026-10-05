# frozen_string_literal: true

class Dashboards::ResolvePeriod
  extend ::LightService::Action

  PERIODS = {
    'all'   => nil,
    'week'  => 1.week,
    'month' => 1.month,
    'year'  => 1.year
  }.freeze

  expects  :requested_period
  promises :period, :since

  executed do |ctx|
    ctx.period = PERIODS.key?(ctx.requested_period) ? ctx.requested_period : 'all'
    ctx.since  = PERIODS[ctx.period]&.ago
  end
end
