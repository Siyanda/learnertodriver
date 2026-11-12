# frozen_string_literal: true

class Dashboards::SummarizeAdmin
  extend ::LightService::Organizer

  def self.call
    with({}).reduce(actions)
  end

  def self.actions
    [
      Dashboards::CountRecords,
      Dashboards::CalculateEvaluationStats,
      Dashboards::CalculateActivityStats,
      Dashboards::CalculateStorageUsage,
      Dashboards::FindRecentEvaluations,
      Dashboards::FindRecentUsers,
    ]
  end
end
