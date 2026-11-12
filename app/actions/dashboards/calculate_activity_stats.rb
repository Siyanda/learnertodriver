# frozen_string_literal: true

class Dashboards::CalculateActivityStats
  extend ::LightService::Action

  WINDOW = 30.days

  Trend = Data.define(:current, :previous) do
    def change
      return if previous.zero?

      ((current - previous) * 100.0 / previous).round
    end
  end

  promises :activity

  executed do |ctx|
    now = Time.current

    ctx.activity = {
      new_users:             trend(scope: User,                 column: :created_at,   now:),
      evaluations_started:   trend(scope: Evaluation,           column: :created_at,   now:),
      evaluations_completed: trend(scope: Evaluation.completed, column: :completed_at, now:),
      comments:              trend(scope: Comment,              column: :created_at,   now:)
    }
  end

  def self.trend(scope:, column:, now:)
    Trend.new(
      current:  scope.where(column => (now - WINDOW)..now).count,
      previous: scope.where(column => (now - (WINDOW * 2))...(now - WINDOW)).count
    )
  end
  private_class_method :trend
end
