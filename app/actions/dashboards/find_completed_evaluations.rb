# frozen_string_literal: true

class Dashboards::FindCompletedEvaluations
  extend ::LightService::Action

  expects  :user, :since
  promises :evaluations

  executed do |ctx|
    scope = ctx.user.evaluations.completed.includes(:quiz).order(completed_at: :desc)
    scope = scope.where(completed_at: ctx.since..) if ctx.since

    ctx.evaluations = scope.to_a
  end
end
