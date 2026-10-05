# frozen_string_literal: true

require 'test_helper'

class EvaluationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user     = create(:user)
    @quiz     = create(:quiz)
    @question = create(:question)
    @right    = create(:answer, question: @question)
    @wrong    = create(:answer, question: @question)

    @quiz.questions << @question
    create(:correct_answer, question: @question, answer: @right)

    @evaluation = create(:evaluation, :started, user: @user, quiz: @quiz)
    @choice     = create(:choice, evaluation: @evaluation, question: @question, answer: nil)

    sign_in_as @user
  end

  test 'saves an answer without finishing the test' do
    patch quiz_evaluation_path(@quiz, @evaluation), params: answer_params(@wrong), as: :turbo_stream

    assert_response :success
    assert_equal @wrong, @choice.reload.answer
    assert_predicate @evaluation.reload, :in_progress?
  end

  test 'finishing the test scores it and shows the result' do
    patch quiz_evaluation_path(@quiz, @evaluation), params: answer_params(@right).merge(commit: 'Submit')

    assert_redirected_to quiz_evaluation_path(@quiz, @evaluation)
    assert_predicate @evaluation.reload, :completed?
    assert_equal 100, @evaluation.score

    follow_redirect!

    assert_select 'h3', text: 'Score: 100%'
    assert_select '.status-badge', text: 'Right'
  end

  test 'unconfirmed users cannot start a test' do
    @user.update!(confirmed_at: nil)

    assert_no_difference 'Evaluation.count' do
      get new_quiz_evaluation_path(create(:quiz))
    end

    assert_redirected_to quizzes_path
    assert_equal I18n.t('evaluations.confirm_email_first'), flash[:alert]
  end

  test "cannot update another user's test" do
    other = create(:evaluation, :started, quiz: @quiz)

    patch quiz_evaluation_path(@quiz, other), params: answer_params(@right)

    assert_response :not_found
  end

  private

  def answer_params(answer)
    choice = { id: @choice.id, question_id: @question.id, answer_id: answer.id }

    { evaluation: { last_choice_id: @choice.id, choices_attributes: { '0' => choice } } }
  end
end
