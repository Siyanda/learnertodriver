# frozen_string_literal: true

require "test_helper"

class Choices::CalculateScoreTest < ActiveSupport::TestCase
  test "sets value to 1.0 when the chosen answer is correct" do
    question       = create(:question)
    answer         = create(:answer, question:)
    correct_answer = create(:correct_answer, question:, answer:)
    choice         = create(:choice, question:, answer:)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::CalculateScore)
      .for(Choices::CalculateScore)
      .with(choice:)

    result = Choices::CalculateScore.execute(ctx)

    assert_predicate result, :success?
    assert_equal 1.0, choice.reload.value
  end

  test "sets value to 0.0 when the chosen answer is incorrect" do
    question       = create(:question)
    correct_answer = create(:answer, question:)
    wrong_answer   = create(:answer, question:)
    create(:correct_answer, question:, answer: correct_answer)
    choice = create(:choice, question:, answer: wrong_answer)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::CalculateScore)
      .for(Choices::CalculateScore)
      .with(choice:)

    result = Choices::CalculateScore.execute(ctx)

    assert_predicate result, :success?
    assert_equal 0.0, choice.reload.value
  end

  test "sets value to 0.0 when no answer has been selected" do
    question = create(:question)
    create(:answer, question:)
    choice   = create(:choice, question:, answer: nil)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::CalculateScore)
      .for(Choices::CalculateScore)
      .with(choice:)

    result = Choices::CalculateScore.execute(ctx)

    assert_predicate result, :success?
    assert_equal 0.0, choice.reload.value
  end
end
