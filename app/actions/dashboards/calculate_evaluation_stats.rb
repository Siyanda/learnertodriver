# frozen_string_literal: true

class Dashboards::CalculateEvaluationStats
  extend ::LightService::Action

  promises :completed_evaluations, :completion_rate, :average_score

  executed do |ctx|
    total     = Evaluation.count
    completed = Evaluation.completed.count
    choices   = Choice.joins(:evaluation).merge(Evaluation.completed)
    answered  = choices.count

    ctx.completed_evaluations = completed
    ctx.completion_rate       = total.zero? ? 0 : (completed * 100.0 / total).round
    ctx.average_score         = answered.zero? ? 0 : (choices.correct.count * 100.0 / answered).round
  end
end
