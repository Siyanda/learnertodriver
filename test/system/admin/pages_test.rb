require "application_system_test_case"

class Admin::PagesTest < ApplicationSystemTestCase
  setup do
    @admin_page = admin_pages(:one)
  end

  test "visiting the index" do
    visit admin_pages_url
    assert_selector "h1", text: "Pages"
  end

  test "should create page" do
    visit admin_pages_url
    click_on "New page"

    fill_in "Content", with: @admin_page.content
    fill_in "Parent", with: @admin_page.parent_id
    fill_in "Published at", with: @admin_page.published_at
    fill_in "Slug", with: @admin_page.slug
    fill_in "Status", with: @admin_page.status
    fill_in "Title", with: @admin_page.title
    fill_in "User", with: @admin_page.user_id
    click_on "Create Page"

    assert_text "Page was successfully created"
    click_on "Back"
  end

  test "should update Page" do
    visit admin_page_url(@admin_page)
    click_on "Edit this page", match: :first

    fill_in "Content", with: @admin_page.content
    fill_in "Parent", with: @admin_page.parent_id
    fill_in "Published at", with: @admin_page.published_at.to_s
    fill_in "Slug", with: @admin_page.slug
    fill_in "Status", with: @admin_page.status
    fill_in "Title", with: @admin_page.title
    fill_in "User", with: @admin_page.user_id
    click_on "Update Page"

    assert_text "Page was successfully updated"
    click_on "Back"
  end

  test "should destroy Page" do
    visit admin_page_url(@admin_page)
    click_on "Destroy this page", match: :first

    assert_text "Page was successfully destroyed"
  end
end
