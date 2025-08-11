# frozen_string_literal: true

class Evaluations::CreateEvaluationChoices
  extend ::LightService::Action

  expects  :evaluation
  promises :choices

  executed do |ctx|
    evaluation = ctx.evaluation

    ctx.choices = evaluation.quiz.questions.ids.map do |question_id|
      evaluation.choices.create!(question_id:)
    end
  rescue ActiveRecord::RecordInvalid => e
    ctx.fail_and_return!("Failed to create choices: #{e.message}")
  end
end
