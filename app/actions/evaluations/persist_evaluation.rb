# frozen_string_literal: true

class Evaluations::PersistEvaluation
  extend ::LightService::Action

  expects :evaluation, :update_attrs

  executed do |ctx|
    next ctx.fail_and_return!(message: ctx.evaluation.errors.full_messages.to_sentence) unless ctx.evaluation.update(ctx.update_attrs)
  end
end
