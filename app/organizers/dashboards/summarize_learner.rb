# frozen_string_literal: true

class Dashboards::SummarizeLearner
  extend ::LightService::Organizer

  def self.call(user:, period: nil)
    with(user:, requested_period: period).reduce(actions)
  end

  def self.actions
    [
      Dashboards::ResolvePeriod,
      Dashboards::FindCompletedEvaluations,
      Dashboards::CalculateScores,
      Dashboards::CalculateLearnerStats,
      Dashboards::FindInProgressEvaluation,
      Dashboards::BuildQuizProgress,
    ]
  end
end
