# frozen_string_literal: true

class Evaluations::LoadChoices
  extend ::LightService::Action

  expects  :evaluation
  promises :choices

  executed do |ctx|
    ctx.choices = ctx.evaluation.choices.to_a
  end
end
