# frozen_string_literal: true

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @question = create(:question)
  end

  test 'is valid with valid attributes' do
    assert_predicate @question, :valid?
  end

  test 'is invalid without content' do
    @question.content = nil

    assert_not @question.valid?
    assert_includes @question.errors[:content], "can't be blank"
  end

  test 'is invalid with an unknown kind' do
    @question.kind = :true_or_false

    assert_not @question.valid?
    assert_includes @question.errors[:kind], 'is not included in the list'
  end

  test 'accepts nested attributes for answers' do
    @question.update!(answers_attributes: [{ name: 'A', value: 1, content: 'Stop', information: 'Red sign' }])

    assert_equal ['Stop'], @question.answers.pluck(:content)
  end

  test 'skips new nested answers with blank content and information' do
    assert_no_difference 'Answer.count' do
      @question.update!(answers_attributes: [{ name: 'A', value: 1, content: '', information: '' }])
    end
  end

  test 'destroys answers and correct answers when question is destroyed' do
    answer = create(:answer, question: @question)
    create(:correct_answer, question: @question, answer:)

    assert_difference({ 'Answer.count' => -1, 'CorrectAnswer.count' => -1 }) do
      @question.destroy
    end
  end

  test 'belongs to many quizzes through quiz question linkages' do
    quiz = create(:quiz)
    quiz.questions << @question

    assert_equal [quiz], @question.reload.quizzes.to_a
  end
end
