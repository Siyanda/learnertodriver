# frozen_string_literal: true

require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase
  setup do
    @quiz       = create(:quiz)
    @question   = create(:question)
    @evaluation = create(:evaluation, quiz: @quiz)
  end

  test 'is valid with valid attributes' do
    assert_predicate @evaluation, :valid?
  end

  test 'is invalid without a score' do
    @evaluation.score = nil

    assert_not @evaluation.valid?
    assert_includes @evaluation.errors[:score], "can't be blank"
  end

  test 'is invalid with an unknown status' do
    @evaluation.status = :abandoned

    assert_not @evaluation.valid?
    assert_includes @evaluation.errors[:status], 'is not included in the list'
  end

  test 'orders choices by position' do
    third_choice = create(:choice, evaluation: @evaluation, position: 3)
    first_choice = create(:choice, evaluation: @evaluation, position: 1)

    assert_equal [first_choice, third_choice], @evaluation.reload.choices.to_a
  end

  test 'destroys choices when evaluation is destroyed' do
    create(:choice, evaluation: @evaluation)

    assert_difference 'Choice.count', -1 do
      @evaluation.destroy
    end
  end

  test 'has no question choices when the quiz has questions but no choices exist' do
    @quiz.questions << @question

    assert_predicate @evaluation, :no_question_choices?
  end

  test 'has question choices once choices exist' do
    @quiz.questions << @question
    create(:choice, evaluation: @evaluation, question: @question)

    assert_not @evaluation.reload.no_question_choices?
  end

  test 'does not report missing choices when the quiz has no questions' do
    assert_not @evaluation.no_question_choices?
  end

  test 'last_active_choice returns the last choice when set' do
    create(:choice, evaluation: @evaluation, position: 1)
    last_choice = create(:choice, evaluation: @evaluation, position: 2)
    @evaluation.update!(last_choice:)

    assert_equal last_choice, @evaluation.last_active_choice
  end

  test 'last_active_choice falls back to the first choice' do
    first_choice = create(:choice, evaluation: @evaluation, position: 1)
    create(:choice, evaluation: @evaluation, position: 2)

    assert_equal first_choice, @evaluation.reload.last_active_choice
  end
end
