# frozen_string_literal: true

class Evaluations::FindUserInProgressEvaluation
  extend ::LightService::Action

  expects  :user, :quiz
  promises :evaluation

  executed do |ctx|
    ctx.evaluation = ctx.user.evaluations.in_progress.find_by(quiz: ctx.quiz)
  end
end
