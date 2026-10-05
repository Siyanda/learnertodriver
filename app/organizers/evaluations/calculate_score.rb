# frozen_string_literal: true

class Evaluations::CalculateScore
  extend ::LightService::Organizer

  def self.call(evaluation:)
    with(evaluation:).reduce(actions)
  end

  def self.actions
    [
      Evaluations::LoadChoices,
      iterate(:choices, [Choices::CalculateScore]),
      Evaluations::RecordScore,
    ]
  end
end
