# frozen_string_literal: true

require 'test_helper'

class CorrectAnswerTest < ActiveSupport::TestCase
  setup do
    @question = create(:question)
    @answer   = create(:answer, question: @question)
  end

  test 'is valid with a question and answer' do
    assert_predicate build(:correct_answer, question: @question, answer: @answer), :valid?
  end

  test 'requires a question and answer' do
    correct_answer = CorrectAnswer.new

    assert_not correct_answer.valid?
    assert_includes correct_answer.errors[:question], 'must exist'
    assert_includes correct_answer.errors[:answer], 'must exist'
  end

  test 'allows each answer to be marked correct only once per question' do
    create(:correct_answer, question: @question, answer: @answer)

    assert_raises(ActiveRecord::RecordNotUnique) do
      create(:correct_answer, question: @question, answer: @answer)
    end
  end
end
