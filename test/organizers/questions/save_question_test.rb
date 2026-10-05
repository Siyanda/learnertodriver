# frozen_string_literal: true

require 'test_helper'

class Questions::SaveQuestionTest < ActiveSupport::TestCase
  setup do
    @question = create(:question)
    @first    = create(:answer, question: @question)
    @second   = create(:answer, question: @question)
  end

  test 'creates correct answers for answers flagged as correct' do
    @question.assign_attributes(answers_attributes: [{ id: @second.id, correct: '1' }])

    result = Questions::SaveQuestion.call(question: @question)

    assert_predicate result, :success?
    assert_equal [@second.id], @question.correct_answers.pluck(:answer_id)
  end

  test 'removes correct answers that are no longer flagged' do
    create(:correct_answer, question: @question, answer: @first)

    @question.assign_attributes(answers_attributes: [{ id: @first.id, correct: '0' }])
    Questions::SaveQuestion.call(question: @question)

    assert_empty @question.correct_answers.reload
  end

  test 'keeps correct answers for answers that were not submitted' do
    create(:correct_answer, question: @question, answer: @first)

    @question.assign_attributes(content: 'Updated?')
    Questions::SaveQuestion.call(question: @question)

    assert_equal [@first.id], @question.correct_answers.pluck(:answer_id)
  end

  test 'fails with the validation errors and saves nothing' do
    @question.assign_attributes(content: '', answers_attributes: [{ id: @first.id, correct: '1' }])

    result = Questions::SaveQuestion.call(question: @question)

    assert_predicate result, :failure?
    assert_match(/Content can't be blank/, result.message)
    assert_empty CorrectAnswer.where(question: @question)
  end

  test 'fails when removing an answer that has been chosen' do
    create(:choice, question: @question, answer: @first)

    @question.assign_attributes(answers_attributes: [{ id: @first.id, _destroy: '1' }])
    result = Questions::SaveQuestion.call(question: @question)

    assert_predicate result, :failure?
    assert_equal I18n.t('admin.questions.answer_in_use'), result.message
    assert Answer.exists?(@first.id)
  end
end
