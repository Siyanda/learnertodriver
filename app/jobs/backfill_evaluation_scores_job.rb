# frozen_string_literal: true

# Scores completed evaluations that finished before scoring ran on completion.
class BackfillEvaluationScoresJob < ApplicationJob
  queue_as :default

  def perform
    Evaluation.completed.find_each.count do |evaluation|
      ::Evaluations::CalculateScore.call(evaluation:).success?
    end
  end
end
