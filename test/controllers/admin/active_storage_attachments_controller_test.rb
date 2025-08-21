require "test_helper"

class Admin::ActiveStorageAttachmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_active_storage_attachment = admin_active_storage_attachments(:one)
  end

  test "should get index" do
    get admin_active_storage_attachments_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_active_storage_attachment_url
    assert_response :success
  end

  test "should create admin_active_storage_attachment" do
    assert_difference("Admin::ActiveStorageAttachment.count") do
      post admin_active_storage_attachments_url, params: { admin_active_storage_attachment: { blob_id: @admin_active_storage_attachment.blob_id, name: @admin_active_storage_attachment.name, record_id: @admin_active_storage_attachment.record_id, record_type: @admin_active_storage_attachment.record_type } }
    end

    assert_redirected_to admin_active_storage_attachment_url(Admin::ActiveStorageAttachment.last)
  end

  test "should show admin_active_storage_attachment" do
    get admin_active_storage_attachment_url(@admin_active_storage_attachment)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_active_storage_attachment_url(@admin_active_storage_attachment)
    assert_response :success
  end

  test "should update admin_active_storage_attachment" do
    patch admin_active_storage_attachment_url(@admin_active_storage_attachment), params: { admin_active_storage_attachment: { blob_id: @admin_active_storage_attachment.blob_id, name: @admin_active_storage_attachment.name, record_id: @admin_active_storage_attachment.record_id, record_type: @admin_active_storage_attachment.record_type } }
    assert_redirected_to admin_active_storage_attachment_url(@admin_active_storage_attachment)
  end

  test "should destroy admin_active_storage_attachment" do
    assert_difference("Admin::ActiveStorageAttachment.count", -1) do
      delete admin_active_storage_attachment_url(@admin_active_storage_attachment)
    end

    assert_redirected_to admin_active_storage_attachments_url
  end
end
