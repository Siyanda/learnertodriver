require "application_system_test_case"

class Admin::ActionTextRichTextsTest < ApplicationSystemTestCase
  setup do
    @admin_action_text_rich_text = admin_action_text_rich_texts(:one)
  end

  test "visiting the index" do
    visit admin_action_text_rich_texts_url
    assert_selector "h1", text: "Action text rich texts"
  end

  test "should create action text rich text" do
    visit admin_action_text_rich_texts_url
    click_on "New action text rich text"

    fill_in "Body", with: @admin_action_text_rich_text.body
    fill_in "Name", with: @admin_action_text_rich_text.name
    fill_in "Record", with: @admin_action_text_rich_text.record_id
    fill_in "Record type", with: @admin_action_text_rich_text.record_type
    click_on "Create Action text rich text"

    assert_text "Action text rich text was successfully created"
    click_on "Back"
  end

  test "should update Action text rich text" do
    visit admin_action_text_rich_text_url(@admin_action_text_rich_text)
    click_on "Edit this action text rich text", match: :first

    fill_in "Body", with: @admin_action_text_rich_text.body
    fill_in "Name", with: @admin_action_text_rich_text.name
    fill_in "Record", with: @admin_action_text_rich_text.record_id
    fill_in "Record type", with: @admin_action_text_rich_text.record_type
    click_on "Update Action text rich text"

    assert_text "Action text rich text was successfully updated"
    click_on "Back"
  end

  test "should destroy Action text rich text" do
    visit admin_action_text_rich_text_url(@admin_action_text_rich_text)
    click_on "Destroy this action text rich text", match: :first

    assert_text "Action text rich text was successfully destroyed"
  end
end
