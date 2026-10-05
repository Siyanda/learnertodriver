# frozen_string_literal: true

class Dashboards::FindInProgressEvaluation
  extend ::LightService::Action

  expects  :user
  promises :in_progress_evaluation

  executed do |ctx|
    ctx.in_progress_evaluation = ctx.user.evaluations
                                    .where(status: %i[started in_progress])
                                    .includes(:quiz)
                                    .order(updated_at: :desc)
                                    .first
  end
end
