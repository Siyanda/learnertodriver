require "test_helper"

class Admin::ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_response = admin_responses(:one)
  end

  test "should get index" do
    get admin_responses_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_response_url
    assert_response :success
  end

  test "should create admin_response" do
    assert_difference("Admin::Response.count") do
      post admin_responses_url, params: { admin_response: { answer_id: @admin_response.answer_id, question_id: @admin_response.question_id } }
    end

    assert_redirected_to admin_response_url(Admin::Response.last)
  end

  test "should show admin_response" do
    get admin_response_url(@admin_response)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_response_url(@admin_response)
    assert_response :success
  end

  test "should update admin_response" do
    patch admin_response_url(@admin_response), params: { admin_response: { answer_id: @admin_response.answer_id, question_id: @admin_response.question_id } }
    assert_redirected_to admin_response_url(@admin_response)
  end

  test "should destroy admin_response" do
    assert_difference("Admin::Response.count", -1) do
      delete admin_response_url(@admin_response)
    end

    assert_redirected_to admin_responses_url
  end
end
