require "test_helper"

class Admin::QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_question = admin_questions(:one)
  end

  test "should get index" do
    get admin_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_question_url
    assert_response :success
  end

  test "should create admin_question" do
    assert_difference("Admin::Question.count") do
      post admin_questions_url, params: { admin_question: { content: @admin_question.content, information: @admin_question.information, kind: @admin_question.kind } }
    end

    assert_redirected_to admin_question_url(Admin::Question.last)
  end

  test "should show admin_question" do
    get admin_question_url(@admin_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_question_url(@admin_question)
    assert_response :success
  end

  test "should update admin_question" do
    patch admin_question_url(@admin_question), params: { admin_question: { content: @admin_question.content, information: @admin_question.information, kind: @admin_question.kind } }
    assert_redirected_to admin_question_url(@admin_question)
  end

  test "should destroy admin_question" do
    assert_difference("Admin::Question.count", -1) do
      delete admin_question_url(@admin_question)
    end

    assert_redirected_to admin_questions_url
  end
end
