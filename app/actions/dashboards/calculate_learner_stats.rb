# frozen_string_literal: true

class Dashboards::CalculateLearnerStats
  extend ::LightService::Action

  expects  :evaluations, :scores
  promises :stats

  executed do |ctx|
    scores = ctx.scores.values

    ctx.stats = {
      completed:     ctx.evaluations.size,
      quizzes_taken: ctx.evaluations.map(&:quiz_id).uniq.size,
      average_score: scores.empty? ? nil : (scores.sum.to_f / scores.size).round,
      best_score:    scores.max
    }
  end
end
