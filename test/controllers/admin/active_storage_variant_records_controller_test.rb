require "test_helper"

class Admin::ActiveStorageVariantRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_active_storage_variant_record = admin_active_storage_variant_records(:one)
  end

  test "should get index" do
    get admin_active_storage_variant_records_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_active_storage_variant_record_url
    assert_response :success
  end

  test "should create admin_active_storage_variant_record" do
    assert_difference("Admin::ActiveStorageVariantRecord.count") do
      post admin_active_storage_variant_records_url, params: { admin_active_storage_variant_record: { blob_id: @admin_active_storage_variant_record.blob_id, variation_digest: @admin_active_storage_variant_record.variation_digest } }
    end

    assert_redirected_to admin_active_storage_variant_record_url(Admin::ActiveStorageVariantRecord.last)
  end

  test "should show admin_active_storage_variant_record" do
    get admin_active_storage_variant_record_url(@admin_active_storage_variant_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_active_storage_variant_record_url(@admin_active_storage_variant_record)
    assert_response :success
  end

  test "should update admin_active_storage_variant_record" do
    patch admin_active_storage_variant_record_url(@admin_active_storage_variant_record), params: { admin_active_storage_variant_record: { blob_id: @admin_active_storage_variant_record.blob_id, variation_digest: @admin_active_storage_variant_record.variation_digest } }
    assert_redirected_to admin_active_storage_variant_record_url(@admin_active_storage_variant_record)
  end

  test "should destroy admin_active_storage_variant_record" do
    assert_difference("Admin::ActiveStorageVariantRecord.count", -1) do
      delete admin_active_storage_variant_record_url(@admin_active_storage_variant_record)
    end

    assert_redirected_to admin_active_storage_variant_records_url
  end
end
