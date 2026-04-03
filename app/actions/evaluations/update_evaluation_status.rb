# frozen_string_literal: true

class Evaluations::UpdateEvaluationStatus
  extend ::LightService::Action

  expects :evaluation

  executed do |ctx|
    next unless ctx.evaluation.started?

    ctx.evaluation.in_progress!
  end
end
