# frozen_string_literal: true

class Users::SummarizeProfile
  extend ::LightService::Organizer

  def self.call(user:)
    with(user:, since: nil).reduce(actions)
  end

  def self.actions
    [
      ::Dashboards::FindCompletedEvaluations,
      ::Dashboards::CalculateScores,
      ::Dashboards::CalculateLearnerStats,
      Users::CountContributions,
    ]
  end
end
