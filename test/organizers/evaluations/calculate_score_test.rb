# frozen_string_literal: true

require 'test_helper'

class Evaluations::CalculateScoreTest < ActiveSupport::TestCase
  test 'calculates scores for all choices in the evaluation' do
    quiz      = create(:quiz)
    question  = create(:question)
    correct   = create(:answer, question:)
    incorrect = create(:answer, question:)

    quiz.questions << question

    create(:correct_answer, question:, answer: correct)

    evaluation    = create(:evaluation, user: create(:user), quiz:)
    first_choice  = create(:choice, evaluation:, question:, answer: correct)
    second_choice = create(:choice, evaluation:, question:, answer: incorrect)

    Evaluations::CalculateScore.call(evaluation:)

    assert_equal 1.0, first_choice.reload.value
    assert_equal 0.0, second_choice.reload.value
  end
end
