require "test_helper"

class Admin::QuizQuestionLinkagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_quiz_question_linkage = admin_quiz_question_linkages(:one)
  end

  test "should get index" do
    get admin_quiz_question_linkages_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_quiz_question_linkage_url
    assert_response :success
  end

  test "should create admin_quiz_question_linkage" do
    assert_difference("Admin::QuizQuestionLinkage.count") do
      post admin_quiz_question_linkages_url, params: { admin_quiz_question_linkage: { question_id: @admin_quiz_question_linkage.question_id, quiz_id: @admin_quiz_question_linkage.quiz_id } }
    end

    assert_redirected_to admin_quiz_question_linkage_url(Admin::QuizQuestionLinkage.last)
  end

  test "should show admin_quiz_question_linkage" do
    get admin_quiz_question_linkage_url(@admin_quiz_question_linkage)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_quiz_question_linkage_url(@admin_quiz_question_linkage)
    assert_response :success
  end

  test "should update admin_quiz_question_linkage" do
    patch admin_quiz_question_linkage_url(@admin_quiz_question_linkage), params: { admin_quiz_question_linkage: { question_id: @admin_quiz_question_linkage.question_id, quiz_id: @admin_quiz_question_linkage.quiz_id } }
    assert_redirected_to admin_quiz_question_linkage_url(@admin_quiz_question_linkage)
  end

  test "should destroy admin_quiz_question_linkage" do
    assert_difference("Admin::QuizQuestionLinkage.count", -1) do
      delete admin_quiz_question_linkage_url(@admin_quiz_question_linkage)
    end

    assert_redirected_to admin_quiz_question_linkages_url
  end
end
