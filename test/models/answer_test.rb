# frozen_string_literal: true

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  setup do
    @question = create(:question)
    @answer   = create(:answer, question: @question)
  end

  test 'is valid with valid attributes' do
    assert_predicate @answer, :valid?
  end

  test 'requires a name, value, content and information' do
    answer = Answer.new(question: @question, value: nil)

    assert_not answer.valid?
    %i[name value content information].each do |attribute|
      assert_includes answer.errors[attribute], "can't be blank"
    end
  end

  test 'is correct when it has a correct answer' do
    create(:correct_answer, question: @question, answer: @answer)

    assert_predicate @answer.reload, :correct?
  end

  test 'is not correct without a correct answer' do
    assert_not @answer.correct?
  end

  test 'uses an explicitly set correct value over the correct answer' do
    create(:correct_answer, question: @question, answer: @answer)
    @answer.reload.correct = false

    assert_not @answer.correct?
  end

  test 'destroys its correct answer when destroyed' do
    create(:correct_answer, question: @question, answer: @answer)

    assert_difference 'CorrectAnswer.count', -1 do
      @answer.destroy
    end
  end
end
