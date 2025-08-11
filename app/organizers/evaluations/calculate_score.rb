# frozen_string_literal: true

class Evaluations::CalculateScore
  extend ::LightService::Organizer

  def self.call(params)
    with(
      evaluation: params[:evaluation],
      choices:    evaluation.choices
    ).reduce(actions)
  end

  def self.actions
    [
      iterate(:choices, [
                Choices::CalculateScore,
              ]),
    ]
  end
end
