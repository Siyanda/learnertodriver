# frozen_string_literal: true

require 'test_helper'

class Admin::QuizzesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quiz     = create(:quiz)
    @question = create(:question)

    sign_in_as create(:user, :admin)
  end

  test 'renders index, show, new and edit' do
    @quiz.questions << @question

    [admin_quizzes_path, admin_quiz_path(@quiz), new_admin_quiz_path, edit_admin_quiz_path(@quiz)].each do |path|
      get path

      assert_response :success
    end
  end

  test 'creates a quiz with questions' do
    assert_difference 'Quiz.count', 1 do
      post admin_quizzes_path, params: { quiz: quiz_params.merge(question_ids: [@question.id]) }
    end

    quiz = Quiz.order(:id).last

    assert_redirected_to admin_quiz_path(quiz)
    assert_equal [@question], quiz.questions.to_a
  end

  test 'rejects an invalid quiz' do
    assert_no_difference 'Quiz.count' do
      post admin_quizzes_path, params: { quiz: quiz_params.merge(title: '') }
    end

    assert_response :unprocessable_content
  end

  test 'updates a quiz' do
    patch admin_quiz_path(@quiz), params: { quiz: { title: 'Rules of the road' } }

    assert_redirected_to admin_quiz_path(@quiz.reload)
    assert_equal 'Rules of the road', @quiz.title
  end

  test 'destroys a quiz' do
    assert_difference 'Quiz.count', -1 do
      delete admin_quiz_path(@quiz)
    end

    assert_redirected_to admin_quizzes_path
  end

  private

  def quiz_params
    { title: 'Signs', description: 'Road signs', information: 'Know your signs', duration: 1800, status: 'draft' }
  end
end
