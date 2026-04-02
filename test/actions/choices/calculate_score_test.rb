# frozen_string_literal: true

require 'test_helper'

class Choices::CalculateScoreTest < ActiveSupport::TestCase
  setup do
    @quiz             = create(:quiz)
    @question         = create(:question)
    @correct_answer   = create(:answer, question: @question)
    @incorrect_answer = create(:answer, question: @question)
    create(:correct_answer, question: @question, answer: @correct_answer)

    @quiz.questions << @question

    @user       = create(:user)
    @evaluation = create(:evaluation, user: @user, quiz: @quiz)
  end

  test 'sets value to 1.0 when the selected answer is correct' do
    choice = create(:choice, evaluation: @evaluation, question: @question, answer: @correct_answer)

    Choices::CalculateScore.execute(choice:)

    assert_equal 1.0, choice.reload.value
  end

  test 'sets value to 0.0 when the selected answer is incorrect' do
    choice = create(:choice, evaluation: @evaluation, question: @question, answer: @incorrect_answer)

    Choices::CalculateScore.execute(choice:)

    assert_equal 0.0, choice.reload.value
  end

  test 'persists the updated value to the database' do
    choice = create(:choice, evaluation: @evaluation, question: @question, answer: @correct_answer)

    Choices::CalculateScore.execute(choice:)

    assert_equal 1.0, Choice.find(choice.id).value
  end
end
