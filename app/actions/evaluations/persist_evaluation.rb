# frozen_string_literal: true

class Evaluations::PersistEvaluation
  extend ::LightService::Action

  expects :evaluation, :update_attrs

  executed do |ctx|
    unless ctx.evaluation.update(ctx.update_attrs)
      next ctx.fail_and_return!(message: ctx.evaluation.errors.full_messages.to_sentence)
    end
  end
end
