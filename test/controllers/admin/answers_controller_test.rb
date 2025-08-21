require "test_helper"

class Admin::AnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_answer = admin_answers(:one)
  end

  test "should get index" do
    get admin_answers_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_answer_url
    assert_response :success
  end

  test "should create admin_answer" do
    assert_difference("Admin::Answer.count") do
      post admin_answers_url, params: { admin_answer: { content: @admin_answer.content, information: @admin_answer.information, name: @admin_answer.name, question_id: @admin_answer.question_id, value: @admin_answer.value } }
    end

    assert_redirected_to admin_answer_url(Admin::Answer.last)
  end

  test "should show admin_answer" do
    get admin_answer_url(@admin_answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_answer_url(@admin_answer)
    assert_response :success
  end

  test "should update admin_answer" do
    patch admin_answer_url(@admin_answer), params: { admin_answer: { content: @admin_answer.content, information: @admin_answer.information, name: @admin_answer.name, question_id: @admin_answer.question_id, value: @admin_answer.value } }
    assert_redirected_to admin_answer_url(@admin_answer)
  end

  test "should destroy admin_answer" do
    assert_difference("Admin::Answer.count", -1) do
      delete admin_answer_url(@admin_answer)
    end

    assert_redirected_to admin_answers_url
  end
end
