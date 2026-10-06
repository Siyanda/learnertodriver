# frozen_string_literal: true

require 'test_helper'

class ChoiceTest < ActiveSupport::TestCase
  setup do
    @evaluation = create(:evaluation)
    @question   = create(:question)
    @answer     = create(:answer, question: @question)
    @choice     = create(:choice, evaluation: @evaluation, question: @question, answer: @answer)
  end

  test 'is valid with valid attributes' do
    assert_predicate @choice, :valid?
  end

  test 'is invalid without a value' do
    @choice.value = nil

    assert_not @choice.valid?
    assert_includes @choice.errors[:value], "can't be blank"
  end

  test 'is valid without an answer' do
    @choice.answer = nil

    assert_predicate @choice, :valid?
  end

  test 'is invalid without a position' do
    @choice.position = nil

    assert_not @choice.valid?
    assert_includes @choice.errors[:position], "can't be blank"
  end

  test 'correct returns choices whose answer is a correct answer for the question' do
    create(:correct_answer, question: @question, answer: @answer)
    wrong_answer = create(:answer, question: @question)
    wrong_choice = create(:choice, evaluation: @evaluation, question: @question, answer: wrong_answer)

    assert_equal [@choice], Choice.correct.to_a
    assert_not_includes Choice.correct, wrong_choice
  end

  test 'correct excludes choices without an answer' do
    create(:correct_answer, question: @question, answer: @answer)
    @choice.update!(answer: nil)

    assert_empty Choice.correct
  end
end
