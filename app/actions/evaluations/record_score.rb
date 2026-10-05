# frozen_string_literal: true

# Stores the evaluation score as the percentage of choices marked correct by
# Choices::CalculateScore.
class Evaluations::RecordScore
  extend ::LightService::Action

  expects :evaluation, :choices

  executed do |ctx|
    correct = ctx.choices.count { |choice| choice.value.to_d == 1 }
    score   = ctx.choices.empty? ? 0 : (correct * 100.0 / ctx.choices.size).round(2)

    ctx.evaluation.update!(score:)
  end
end
