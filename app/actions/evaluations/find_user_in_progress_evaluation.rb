# frozen_string_literal: true

class Evaluations::FindUserInProgressEvaluation
  extend ::LightService::Action

  expects :user, :quiz
  promises :evaluation

  executed do |ctx|
    user = ctx.user
    quiz = ctx.quiz

    ctx.evaluation = user.evaluations.in_progress.find_by(quiz:)
  end
end
