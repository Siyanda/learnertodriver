require "test_helper"

class Admin::ChoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_choice = admin_choices(:one)
  end

  test "should get index" do
    get admin_choices_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_choice_url
    assert_response :success
  end

  test "should create admin_choice" do
    assert_difference("Admin::Choice.count") do
      post admin_choices_url, params: { admin_choice: { answer_id: @admin_choice.answer_id, content: @admin_choice.content, evaluation_id: @admin_choice.evaluation_id, name: @admin_choice.name, position: @admin_choice.position, question_id: @admin_choice.question_id, value: @admin_choice.value } }
    end

    assert_redirected_to admin_choice_url(Admin::Choice.last)
  end

  test "should show admin_choice" do
    get admin_choice_url(@admin_choice)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_choice_url(@admin_choice)
    assert_response :success
  end

  test "should update admin_choice" do
    patch admin_choice_url(@admin_choice), params: { admin_choice: { answer_id: @admin_choice.answer_id, content: @admin_choice.content, evaluation_id: @admin_choice.evaluation_id, name: @admin_choice.name, position: @admin_choice.position, question_id: @admin_choice.question_id, value: @admin_choice.value } }
    assert_redirected_to admin_choice_url(@admin_choice)
  end

  test "should destroy admin_choice" do
    assert_difference("Admin::Choice.count", -1) do
      delete admin_choice_url(@admin_choice)
    end

    assert_redirected_to admin_choices_url
  end
end
