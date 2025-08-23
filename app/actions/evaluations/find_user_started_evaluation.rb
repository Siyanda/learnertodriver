# frozen_string_literal: true

class Evaluations::FindUserStartedEvaluation
  extend ::LightService::Action

  expects  :user, :quiz
  promises :evaluation

  executed do |ctx|
    user = ctx.user
    quiz = ctx.quiz

    ctx.evaluation = user.evaluations.started.find_by(quiz:)
  end
end
