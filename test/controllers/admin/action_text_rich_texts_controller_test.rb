require "test_helper"

class Admin::ActionTextRichTextsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_action_text_rich_text = admin_action_text_rich_texts(:one)
  end

  test "should get index" do
    get admin_action_text_rich_texts_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_action_text_rich_text_url
    assert_response :success
  end

  test "should create admin_action_text_rich_text" do
    assert_difference("Admin::ActionTextRichText.count") do
      post admin_action_text_rich_texts_url, params: { admin_action_text_rich_text: { body: @admin_action_text_rich_text.body, name: @admin_action_text_rich_text.name, record_id: @admin_action_text_rich_text.record_id, record_type: @admin_action_text_rich_text.record_type } }
    end

    assert_redirected_to admin_action_text_rich_text_url(Admin::ActionTextRichText.last)
  end

  test "should show admin_action_text_rich_text" do
    get admin_action_text_rich_text_url(@admin_action_text_rich_text)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_action_text_rich_text_url(@admin_action_text_rich_text)
    assert_response :success
  end

  test "should update admin_action_text_rich_text" do
    patch admin_action_text_rich_text_url(@admin_action_text_rich_text), params: { admin_action_text_rich_text: { body: @admin_action_text_rich_text.body, name: @admin_action_text_rich_text.name, record_id: @admin_action_text_rich_text.record_id, record_type: @admin_action_text_rich_text.record_type } }
    assert_redirected_to admin_action_text_rich_text_url(@admin_action_text_rich_text)
  end

  test "should destroy admin_action_text_rich_text" do
    assert_difference("Admin::ActionTextRichText.count", -1) do
      delete admin_action_text_rich_text_url(@admin_action_text_rich_text)
    end

    assert_redirected_to admin_action_text_rich_texts_url
  end
end
