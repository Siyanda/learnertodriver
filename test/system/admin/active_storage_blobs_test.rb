require "application_system_test_case"

class Admin::ActiveStorageBlobsTest < ApplicationSystemTestCase
  setup do
    @admin_active_storage_blob = admin_active_storage_blobs(:one)
  end

  test "visiting the index" do
    visit admin_active_storage_blobs_url
    assert_selector "h1", text: "Active storage blobs"
  end

  test "should create active storage blob" do
    visit admin_active_storage_blobs_url
    click_on "New active storage blob"

    fill_in "Byte size", with: @admin_active_storage_blob.byte_size
    fill_in "Checksum", with: @admin_active_storage_blob.checksum
    fill_in "Content type", with: @admin_active_storage_blob.content_type
    fill_in "Filename", with: @admin_active_storage_blob.filename
    fill_in "Key", with: @admin_active_storage_blob.key
    fill_in "Metadata", with: @admin_active_storage_blob.metadata
    fill_in "Service name", with: @admin_active_storage_blob.service_name
    click_on "Create Active storage blob"

    assert_text "Active storage blob was successfully created"
    click_on "Back"
  end

  test "should update Active storage blob" do
    visit admin_active_storage_blob_url(@admin_active_storage_blob)
    click_on "Edit this active storage blob", match: :first

    fill_in "Byte size", with: @admin_active_storage_blob.byte_size
    fill_in "Checksum", with: @admin_active_storage_blob.checksum
    fill_in "Content type", with: @admin_active_storage_blob.content_type
    fill_in "Filename", with: @admin_active_storage_blob.filename
    fill_in "Key", with: @admin_active_storage_blob.key
    fill_in "Metadata", with: @admin_active_storage_blob.metadata
    fill_in "Service name", with: @admin_active_storage_blob.service_name
    click_on "Update Active storage blob"

    assert_text "Active storage blob was successfully updated"
    click_on "Back"
  end

  test "should destroy Active storage blob" do
    visit admin_active_storage_blob_url(@admin_active_storage_blob)
    click_on "Destroy this active storage blob", match: :first

    assert_text "Active storage blob was successfully destroyed"
  end
end
