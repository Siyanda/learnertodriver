# frozen_string_literal: true

require 'test_helper'

class Dashboards::CalculateScoresTest < ActiveSupport::TestCase
  test 'scores choices against correct answers, not choice values' do
    evaluation = create(:evaluation, :completed)
    right      = create(:choice, evaluation:, value: 0.0)
    create(:choice, evaluation:, value: 1.0, position: 1)
    create(:choice, evaluation:, answer: nil, position: 2)
    create(:correct_answer, question: right.question, answer: right.answer)

    result = Dashboards::CalculateScores.execute(evaluations: [evaluation])

    assert_equal({ evaluation.id => 33 }, result.scores)
  end

  test 'returns no scores for no evaluations' do
    assert_empty Dashboards::CalculateScores.execute(evaluations: []).scores
  end
end
