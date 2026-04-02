# frozen_string_literal: true

class Choices::CalculateScore
  extend ::LightService::Action

  expects :choice

  executed do |ctx|
    choice          = ctx.choice
    correct_answers = choice.question.correct_answers.pluck(:answer_id)

    choice.update!(value: correct_answers.include?(choice.answer_id) ? 1.0 : 0.0)
  end
end
