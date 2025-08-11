# frozen_string_literal: true

module Choice
  class CalculateScore
    extend ::LightService::Action

    expects  :evaluation

    executed do |ctx|
      evaluation = ctx.evaluation
    end
  end
end