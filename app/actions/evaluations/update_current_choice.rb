# frozen_string_literal: true

class Evaluations::UpdateCurrentChoice
  extend ::LightService::Action

  expects :evaluation, :choice_id
  promises :current_choice

  executed do |ctx|
    ctx.current_choice =
      ctx.evaluation.choices.find_by(id: ctx.choice_id) ||
      ctx.evaluation.last_active_choice

    next unless ctx.current_choice

    ctx.current_choice.update(
      name: ctx.current_choice.question.content,
      content: ctx.current_choice.answer&.content
    )
  end
end
