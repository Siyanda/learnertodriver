# frozen_string_literal: true

require 'test_helper'

class Admin::EvaluationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @evaluation = create(:evaluation, :completed)
    @question   = create(:question)
    @answer     = create(:answer, question: @question)

    create(:correct_answer, question: @question, answer: @answer)
    create(:choice, evaluation: @evaluation, question: @question, answer: @answer)

    sign_in_as create(:user, :admin)
  end

  test 'lists evaluations' do
    get admin_evaluations_path

    assert_response :success
    assert_select "#evaluation_#{@evaluation.id}"
  end

  test 'shows choices' do
    get admin_evaluation_path(@evaluation)

    assert_response :success
    assert_select '.status-badge', text: 'Right'
  end

  test 'destroys an evaluation' do
    assert_difference 'Evaluation.count', -1 do
      delete admin_evaluation_path(@evaluation)
    end

    assert_redirected_to admin_evaluations_path
  end
end
