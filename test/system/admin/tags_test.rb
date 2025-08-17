require "application_system_test_case"

class Admin::TagsTest < ApplicationSystemTestCase
  setup do
    @admin_tag = admin_tags(:one)
  end

  test "visiting the index" do
    visit admin_tags_url
    assert_selector "h1", text: "Tags"
  end

  test "should create tag" do
    visit admin_tags_url
    click_on "New tag"

    fill_in "Slug", with: @admin_tag.slug
    fill_in "Status", with: @admin_tag.status
    fill_in "Title", with: @admin_tag.title
    click_on "Create Tag"

    assert_text "Tag was successfully created"
    click_on "Back"
  end

  test "should update Tag" do
    visit admin_tag_url(@admin_tag)
    click_on "Edit this tag", match: :first

    fill_in "Slug", with: @admin_tag.slug
    fill_in "Status", with: @admin_tag.status
    fill_in "Title", with: @admin_tag.title
    click_on "Update Tag"

    assert_text "Tag was successfully updated"
    click_on "Back"
  end

  test "should destroy Tag" do
    visit admin_tag_url(@admin_tag)
    click_on "Destroy this tag", match: :first

    assert_text "Tag was successfully destroyed"
  end
end
