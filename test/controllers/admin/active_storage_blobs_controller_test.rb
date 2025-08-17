require "test_helper"

class Admin::ActiveStorageBlobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_active_storage_blob = admin_active_storage_blobs(:one)
  end

  test "should get index" do
    get admin_active_storage_blobs_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_active_storage_blob_url
    assert_response :success
  end

  test "should create admin_active_storage_blob" do
    assert_difference("Admin::ActiveStorageBlob.count") do
      post admin_active_storage_blobs_url, params: { admin_active_storage_blob: { byte_size: @admin_active_storage_blob.byte_size, checksum: @admin_active_storage_blob.checksum, content_type: @admin_active_storage_blob.content_type, filename: @admin_active_storage_blob.filename, key: @admin_active_storage_blob.key, metadata: @admin_active_storage_blob.metadata, service_name: @admin_active_storage_blob.service_name } }
    end

    assert_redirected_to admin_active_storage_blob_url(Admin::ActiveStorageBlob.last)
  end

  test "should show admin_active_storage_blob" do
    get admin_active_storage_blob_url(@admin_active_storage_blob)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_active_storage_blob_url(@admin_active_storage_blob)
    assert_response :success
  end

  test "should update admin_active_storage_blob" do
    patch admin_active_storage_blob_url(@admin_active_storage_blob), params: { admin_active_storage_blob: { byte_size: @admin_active_storage_blob.byte_size, checksum: @admin_active_storage_blob.checksum, content_type: @admin_active_storage_blob.content_type, filename: @admin_active_storage_blob.filename, key: @admin_active_storage_blob.key, metadata: @admin_active_storage_blob.metadata, service_name: @admin_active_storage_blob.service_name } }
    assert_redirected_to admin_active_storage_blob_url(@admin_active_storage_blob)
  end

  test "should destroy admin_active_storage_blob" do
    assert_difference("Admin::ActiveStorageBlob.count", -1) do
      delete admin_active_storage_blob_url(@admin_active_storage_blob)
    end

    assert_redirected_to admin_active_storage_blobs_url
  end
end
