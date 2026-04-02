# frozen_string_literal: true

require "test_helper"

class Evaluations::CalculateScoreTest < ActiveSupport::TestCase
  test "scores choices correctly when answers are correct" do
    quiz       = create(:quiz)
    user       = create(:user)
    evaluation = create(:evaluation, user:, quiz:)
    question   = create(:question)
    answer     = create(:answer, question:, value: 1)
    create(:correct_answer, question:, answer:)
    create(:choice, evaluation:, question:, answer:)

    result = Evaluations::CalculateScore.call(evaluation)

    assert_predicate result, :success?
    assert_equal 1.0, evaluation.choices.first.reload.value
  end

  test "scores choices as zero when answer is incorrect" do
    quiz           = create(:quiz)
    user           = create(:user)
    evaluation     = create(:evaluation, user:, quiz:)
    question       = create(:question)
    correct_answer = create(:answer, question:)
    wrong_answer   = create(:answer, question:)
    create(:correct_answer, question:, answer: correct_answer)
    create(:choice, evaluation:, question:, answer: wrong_answer)

    result = Evaluations::CalculateScore.call(evaluation)

    assert_predicate result, :success?
    assert_equal 0.0, evaluation.choices.first.reload.value
  end

  test "succeeds with no choices" do
    evaluation = create(:evaluation)

    result = Evaluations::CalculateScore.call(evaluation)

    assert_predicate result, :success?
  end
end
