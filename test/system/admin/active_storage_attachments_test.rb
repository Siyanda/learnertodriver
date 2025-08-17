require "application_system_test_case"

class Admin::ActiveStorageAttachmentsTest < ApplicationSystemTestCase
  setup do
    @admin_active_storage_attachment = admin_active_storage_attachments(:one)
  end

  test "visiting the index" do
    visit admin_active_storage_attachments_url
    assert_selector "h1", text: "Active storage attachments"
  end

  test "should create active storage attachment" do
    visit admin_active_storage_attachments_url
    click_on "New active storage attachment"

    fill_in "Blob", with: @admin_active_storage_attachment.blob_id
    fill_in "Name", with: @admin_active_storage_attachment.name
    fill_in "Record", with: @admin_active_storage_attachment.record_id
    fill_in "Record type", with: @admin_active_storage_attachment.record_type
    click_on "Create Active storage attachment"

    assert_text "Active storage attachment was successfully created"
    click_on "Back"
  end

  test "should update Active storage attachment" do
    visit admin_active_storage_attachment_url(@admin_active_storage_attachment)
    click_on "Edit this active storage attachment", match: :first

    fill_in "Blob", with: @admin_active_storage_attachment.blob_id
    fill_in "Name", with: @admin_active_storage_attachment.name
    fill_in "Record", with: @admin_active_storage_attachment.record_id
    fill_in "Record type", with: @admin_active_storage_attachment.record_type
    click_on "Update Active storage attachment"

    assert_text "Active storage attachment was successfully updated"
    click_on "Back"
  end

  test "should destroy Active storage attachment" do
    visit admin_active_storage_attachment_url(@admin_active_storage_attachment)
    click_on "Destroy this active storage attachment", match: :first

    assert_text "Active storage attachment was successfully destroyed"
  end
end
