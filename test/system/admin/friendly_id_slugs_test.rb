require "application_system_test_case"

class Admin::FriendlyIdSlugsTest < ApplicationSystemTestCase
  setup do
    @admin_friendly_id_slug = admin_friendly_id_slugs(:one)
  end

  test "visiting the index" do
    visit admin_friendly_id_slugs_url
    assert_selector "h1", text: "Friendly id slugs"
  end

  test "should create friendly id slug" do
    visit admin_friendly_id_slugs_url
    click_on "New friendly id slug"

    fill_in "Scope", with: @admin_friendly_id_slug.scope
    fill_in "Slug", with: @admin_friendly_id_slug.slug
    fill_in "Sluggable", with: @admin_friendly_id_slug.sluggable_id
    fill_in "Sluggable type", with: @admin_friendly_id_slug.sluggable_type
    click_on "Create Friendly id slug"

    assert_text "Friendly id slug was successfully created"
    click_on "Back"
  end

  test "should update Friendly id slug" do
    visit admin_friendly_id_slug_url(@admin_friendly_id_slug)
    click_on "Edit this friendly id slug", match: :first

    fill_in "Scope", with: @admin_friendly_id_slug.scope
    fill_in "Slug", with: @admin_friendly_id_slug.slug
    fill_in "Sluggable", with: @admin_friendly_id_slug.sluggable_id
    fill_in "Sluggable type", with: @admin_friendly_id_slug.sluggable_type
    click_on "Update Friendly id slug"

    assert_text "Friendly id slug was successfully updated"
    click_on "Back"
  end

  test "should destroy Friendly id slug" do
    visit admin_friendly_id_slug_url(@admin_friendly_id_slug)
    click_on "Destroy this friendly id slug", match: :first

    assert_text "Friendly id slug was successfully destroyed"
  end
end
