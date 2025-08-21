require "application_system_test_case"

class Admin::TaggingsTest < ApplicationSystemTestCase
  setup do
    @admin_tagging = admin_taggings(:one)
  end

  test "visiting the index" do
    visit admin_taggings_url
    assert_selector "h1", text: "Taggings"
  end

  test "should create tagging" do
    visit admin_taggings_url
    click_on "New tagging"

    fill_in "Tag", with: @admin_tagging.tag_id
    fill_in "Taggable", with: @admin_tagging.taggable_id
    fill_in "Taggable type", with: @admin_tagging.taggable_type
    click_on "Create Tagging"

    assert_text "Tagging was successfully created"
    click_on "Back"
  end

  test "should update Tagging" do
    visit admin_tagging_url(@admin_tagging)
    click_on "Edit this tagging", match: :first

    fill_in "Tag", with: @admin_tagging.tag_id
    fill_in "Taggable", with: @admin_tagging.taggable_id
    fill_in "Taggable type", with: @admin_tagging.taggable_type
    click_on "Update Tagging"

    assert_text "Tagging was successfully updated"
    click_on "Back"
  end

  test "should destroy Tagging" do
    visit admin_tagging_url(@admin_tagging)
    click_on "Destroy this tagging", match: :first

    assert_text "Tagging was successfully destroyed"
  end
end
