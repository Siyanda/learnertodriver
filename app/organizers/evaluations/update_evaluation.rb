# frozen_string_literal: true

class Evaluations::UpdateEvaluation
  extend ::LightService::Organizer

  def self.call(evaluation:, params:, choice_id:, commit:)
    with(
      evaluation:,
      params:,
      choice_id:,
      commit:
    ).reduce(actions)
  end

  def self.actions
    [
      Evaluations::PrepareUpdateAttributes,
      Evaluations::PersistEvaluation,
      Evaluations::UpdateEvaluationStatus,
      Evaluations::UpdateCurrentChoice,
    ]
  end
end
