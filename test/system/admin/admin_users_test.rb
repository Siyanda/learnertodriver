require "application_system_test_case"

class Admin::AdminUsersTest < ApplicationSystemTestCase
  setup do
    @admin_admin_user = admin_admin_users(:one)
  end

  test "visiting the index" do
    visit admin_admin_users_url
    assert_selector "h1", text: "Admin users"
  end

  test "should create admin user" do
    visit admin_admin_users_url
    click_on "New admin user"

    fill_in "Email", with: @admin_admin_user.email
    fill_in "Password digest", with: @admin_admin_user.password_digest
    click_on "Create Admin user"

    assert_text "Admin user was successfully created"
    click_on "Back"
  end

  test "should update Admin user" do
    visit admin_admin_user_url(@admin_admin_user)
    click_on "Edit this admin user", match: :first

    fill_in "Email", with: @admin_admin_user.email
    fill_in "Password digest", with: @admin_admin_user.password_digest
    click_on "Update Admin user"

    assert_text "Admin user was successfully updated"
    click_on "Back"
  end

  test "should destroy Admin user" do
    visit admin_admin_user_url(@admin_admin_user)
    click_on "Destroy this admin user", match: :first

    assert_text "Admin user was successfully destroyed"
  end
end
