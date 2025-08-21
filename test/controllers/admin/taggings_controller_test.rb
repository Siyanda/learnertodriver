require "test_helper"

class Admin::TaggingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_tagging = admin_taggings(:one)
  end

  test "should get index" do
    get admin_taggings_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_tagging_url
    assert_response :success
  end

  test "should create admin_tagging" do
    assert_difference("Admin::Tagging.count") do
      post admin_taggings_url, params: { admin_tagging: { tag_id: @admin_tagging.tag_id, taggable_id: @admin_tagging.taggable_id, taggable_type: @admin_tagging.taggable_type } }
    end

    assert_redirected_to admin_tagging_url(Admin::Tagging.last)
  end

  test "should show admin_tagging" do
    get admin_tagging_url(@admin_tagging)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_tagging_url(@admin_tagging)
    assert_response :success
  end

  test "should update admin_tagging" do
    patch admin_tagging_url(@admin_tagging), params: { admin_tagging: { tag_id: @admin_tagging.tag_id, taggable_id: @admin_tagging.taggable_id, taggable_type: @admin_tagging.taggable_type } }
    assert_redirected_to admin_tagging_url(@admin_tagging)
  end

  test "should destroy admin_tagging" do
    assert_difference("Admin::Tagging.count", -1) do
      delete admin_tagging_url(@admin_tagging)
    end

    assert_redirected_to admin_taggings_url
  end
end
