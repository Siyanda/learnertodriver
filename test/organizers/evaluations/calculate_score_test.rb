# frozen_string_literal: true

require 'test_helper'

class Evaluations::CalculateScoreTest < ActiveSupport::TestCase
  test 'calculates scores for all choices in the evaluation' do
    quiz     = create(:quiz)
    question = create(:question)
    correct  = create(:answer, question:)
    wrong    = create(:answer, question:)
    create(:correct_answer, question:, answer: correct)

    quiz.questions << question

    evaluation = create(:evaluation, user: create(:user), quiz:)
    c1 = create(:choice, evaluation:, question:, answer: correct)
    c2 = create(:choice, evaluation:, question:, answer: wrong)

    Evaluations::CalculateScore.call(evaluation)

    assert_equal 1.0, c1.reload.value
    assert_equal 0.0, c2.reload.value
  end
end
