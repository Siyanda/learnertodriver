# frozen_string_literal: true

# Scores each evaluation as the percentage of its choices that match a
# CorrectAnswer, so it doesn't depend on `choices.value` being calculated.
class Dashboards::CalculateScores
  extend ::LightService::Action

  expects  :evaluations
  promises :scores

  executed do |ctx|
    choices = Choice.where(evaluation_id: ctx.evaluations.map(&:id))
    totals  = choices.group(:evaluation_id).count
    correct = choices.correct.group(:evaluation_id).count

    ctx.scores = totals.to_h do |evaluation_id, total|
      [evaluation_id, (correct.fetch(evaluation_id, 0) * 100.0 / total).round]
    end
  end
end
