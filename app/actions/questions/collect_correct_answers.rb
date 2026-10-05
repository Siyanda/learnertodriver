# frozen_string_literal: true

# Reads the virtual `correct` flag before saving: once the question is saved,
# reloading `answers` resets unsaved attributes like `correct`.
class Questions::CollectCorrectAnswers
  extend ::LightService::Action

  expects  :question
  promises :correct_answers

  executed do |ctx|
    ctx.correct_answers = ctx.question.answers.reject(&:marked_for_destruction?).select(&:correct?)
  end
end
