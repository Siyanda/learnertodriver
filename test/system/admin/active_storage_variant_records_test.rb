require "application_system_test_case"

class Admin::ActiveStorageVariantRecordsTest < ApplicationSystemTestCase
  setup do
    @admin_active_storage_variant_record = admin_active_storage_variant_records(:one)
  end

  test "visiting the index" do
    visit admin_active_storage_variant_records_url
    assert_selector "h1", text: "Active storage variant records"
  end

  test "should create active storage variant record" do
    visit admin_active_storage_variant_records_url
    click_on "New active storage variant record"

    fill_in "Blob", with: @admin_active_storage_variant_record.blob_id
    fill_in "Variation digest", with: @admin_active_storage_variant_record.variation_digest
    click_on "Create Active storage variant record"

    assert_text "Active storage variant record was successfully created"
    click_on "Back"
  end

  test "should update Active storage variant record" do
    visit admin_active_storage_variant_record_url(@admin_active_storage_variant_record)
    click_on "Edit this active storage variant record", match: :first

    fill_in "Blob", with: @admin_active_storage_variant_record.blob_id
    fill_in "Variation digest", with: @admin_active_storage_variant_record.variation_digest
    click_on "Update Active storage variant record"

    assert_text "Active storage variant record was successfully updated"
    click_on "Back"
  end

  test "should destroy Active storage variant record" do
    visit admin_active_storage_variant_record_url(@admin_active_storage_variant_record)
    click_on "Destroy this active storage variant record", match: :first

    assert_text "Active storage variant record was successfully destroyed"
  end
end
