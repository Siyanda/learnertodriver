# frozen_string_literal: true

require 'test_helper'

class Admin::QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = create(:question)
    @answer   = create(:answer, question: @question)

    sign_in_as create(:user, :admin)
  end

  test 'renders index, show, new and edit' do
    [admin_questions_path, admin_question_path(@question), new_admin_question_path,
     edit_admin_question_path(@question)].each do |path|
      get path

      assert_response :success
    end
  end

  test 'creates a question with answers and marks the correct one' do
    assert_difference -> { Question.count } => 1, -> { Answer.count } => 2, -> { CorrectAnswer.count } => 1 do
      post admin_questions_path, params: { question: question_params }
    end

    question = Question.order(:id).last

    assert_redirected_to admin_question_path(question)
    assert_equal(['Stop'], question.correct_answers.map { it.answer.content })
  end

  test 'skips blank new answer rows' do
    params = question_params
    params[:answers_attributes]['2'] = { name: 'answer_3', content: '', information: '', value: 1, correct: '0' }

    assert_difference 'Answer.count', 2 do
      post admin_questions_path, params: { question: params }
    end
  end

  test 'rejects an invalid question' do
    assert_no_difference 'Question.count' do
      post admin_questions_path, params: { question: question_params.merge(content: '') }
    end

    assert_response :unprocessable_content
  end

  test 'updates the correct answer' do
    create(:correct_answer, question: @question, answer: @answer)
    other = create(:answer, question: @question)

    patch admin_question_path(@question), params: { question: { answers_attributes: {
      '0' => { id: @answer.id, correct: '0' },
      '1' => { id: other.id,   correct: '1' }
    } } }

    assert_redirected_to admin_question_path(@question)
    assert_equal [other.id], @question.correct_answers.pluck(:answer_id)
  end

  test 'removes an answer' do
    patch admin_question_path(@question), params: { question: { answers_attributes: {
      '0' => { id: @answer.id, _destroy: '1' }
    } } }

    assert_redirected_to admin_question_path(@question)
    assert_empty @question.answers.reload
  end

  test 'destroys a question' do
    assert_difference 'Question.count', -1 do
      delete admin_question_path(@question)
    end

    assert_redirected_to admin_questions_path
  end

  test 'does not destroy a question that has been answered' do
    create(:choice, question: @question, answer: @answer)

    assert_no_difference 'Question.count' do
      delete admin_question_path(@question)
    end

    assert_redirected_to admin_question_path(@question)
  end

  private

  def question_params
    {
      content:            'What does a red octagon mean?',
      kind:               'single_choice',
      answers_attributes: {
        '0' => { name: 'answer_1', content: 'Stop',  information: 'Signs', value: 1, correct: '1' },
        '1' => { name: 'answer_2', content: 'Yield', information: 'Signs', value: 1, correct: '0' }
      }
    }
  end
end
