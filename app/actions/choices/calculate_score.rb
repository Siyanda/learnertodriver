# frozen_string_literal: true

class Choices::CalculateScore
  extend ::LightService::Action

  expects :choice

  executed do |ctx|
    choice  = ctx.choice
    answers = choice.question.answers.pluck(:answer_id)

    choice.update!(value: answers.include?(choice.answer_id) ? 1.0 : 0.0)
  end
end
