# frozen_string_literal: true

class Evaluations::FindUserStartedEvaluation
  extend ::LightService::Action

  expects  :user, :quiz
  promises :evaluation

  executed do |ctx|
    ctx.evaluation = ctx.user.evaluations.started.find_by(quiz: ctx.quiz)
  end
end
