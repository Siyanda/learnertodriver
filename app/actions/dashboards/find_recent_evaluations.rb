# frozen_string_literal: true

class Dashboards::FindRecentEvaluations
  extend ::LightService::Action

  promises :recent_evaluations

  executed do |ctx|
    ctx.recent_evaluations = Evaluation.includes(:user, :quiz).order(created_at: :desc).limit(10)
  end
end
