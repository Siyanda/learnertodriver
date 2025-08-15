# frozen_string_literal: true

class Choices::CalculateScore
  extend ::LightService::Action

  expects :user, :quiz, :evaluation
  promises :evaluation

  executed do |ctx|
    ctx.evaluation = ctx.user.evaluations.create!(
      quiz:       ctx.quiz,
      score:      0,
      status:     :started,
      started_at: DateTime.now
    )
  end
end
