require "test_helper"

class Admin::CorrectAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_correct_answer = admin_correct_answers(:one)
  end

  test "should get index" do
    get admin_correct_answers_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_correct_answer_url
    assert_response :success
  end

  test "should create admin_correct_answer" do
    assert_difference("Admin::CorrectAnswer.count") do
      post admin_correct_answers_url, params: { admin_correct_answer: { answer_id: @admin_correct_answer.answer_id, question_id: @admin_correct_answer.question_id } }
    end

    assert_redirected_to admin_correct_answer_url(Admin::CorrectAnswer.last)
  end

  test "should show admin_correct_answer" do
    get admin_correct_answer_url(@admin_correct_answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_correct_answer_url(@admin_correct_answer)
    assert_response :success
  end

  test "should update admin_correct_answer" do
    patch admin_correct_answer_url(@admin_correct_answer), params: { admin_correct_answer: { answer_id: @admin_correct_answer.answer_id, question_id: @admin_correct_answer.question_id } }
    assert_redirected_to admin_correct_answer_url(@admin_correct_answer)
  end

  test "should destroy admin_correct_answer" do
    assert_difference("Admin::CorrectAnswer.count", -1) do
      delete admin_correct_answer_url(@admin_correct_answer)
    end

    assert_redirected_to admin_correct_answers_url
  end
end
