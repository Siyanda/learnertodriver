# frozen_string_literal: true

class Evaluations::FindUserCompletedEvaluation
  extend ::LightService::Action

  expects  :user, :quiz
  promises :evaluation

  executed do |ctx|
    ctx.evaluation = ctx.user.evaluations.completed.find_by(quiz: ctx.quiz)
  end
end
