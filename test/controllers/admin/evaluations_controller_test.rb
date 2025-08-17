require "test_helper"

class Admin::EvaluationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_evaluation = admin_evaluations(:one)
  end

  test "should get index" do
    get admin_evaluations_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_evaluation_url
    assert_response :success
  end

  test "should create admin_evaluation" do
    assert_difference("Admin::Evaluation.count") do
      post admin_evaluations_url, params: { admin_evaluation: { completed_at: @admin_evaluation.completed_at, last_choice_id: @admin_evaluation.last_choice_id, quiz_id: @admin_evaluation.quiz_id, score: @admin_evaluation.score, started_at: @admin_evaluation.started_at, status: @admin_evaluation.status, user_id: @admin_evaluation.user_id } }
    end

    assert_redirected_to admin_evaluation_url(Admin::Evaluation.last)
  end

  test "should show admin_evaluation" do
    get admin_evaluation_url(@admin_evaluation)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_evaluation_url(@admin_evaluation)
    assert_response :success
  end

  test "should update admin_evaluation" do
    patch admin_evaluation_url(@admin_evaluation), params: { admin_evaluation: { completed_at: @admin_evaluation.completed_at, last_choice_id: @admin_evaluation.last_choice_id, quiz_id: @admin_evaluation.quiz_id, score: @admin_evaluation.score, started_at: @admin_evaluation.started_at, status: @admin_evaluation.status, user_id: @admin_evaluation.user_id } }
    assert_redirected_to admin_evaluation_url(@admin_evaluation)
  end

  test "should destroy admin_evaluation" do
    assert_difference("Admin::Evaluation.count", -1) do
      delete admin_evaluation_url(@admin_evaluation)
    end

    assert_redirected_to admin_evaluations_url
  end
end
