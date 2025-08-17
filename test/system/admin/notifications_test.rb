require "application_system_test_case"

class Admin::NotificationsTest < ApplicationSystemTestCase
  setup do
    @admin_notification = admin_notifications(:one)
  end

  test "visiting the index" do
    visit admin_notifications_url
    assert_selector "h1", text: "Notifications"
  end

  test "should create notification" do
    visit admin_notifications_url
    click_on "New notification"

    fill_in "Content", with: @admin_notification.content
    fill_in "Notifiable", with: @admin_notification.notifiable_id
    fill_in "Notifiable type", with: @admin_notification.notifiable_type
    click_on "Create Notification"

    assert_text "Notification was successfully created"
    click_on "Back"
  end

  test "should update Notification" do
    visit admin_notification_url(@admin_notification)
    click_on "Edit this notification", match: :first

    fill_in "Content", with: @admin_notification.content
    fill_in "Notifiable", with: @admin_notification.notifiable_id
    fill_in "Notifiable type", with: @admin_notification.notifiable_type
    click_on "Update Notification"

    assert_text "Notification was successfully updated"
    click_on "Back"
  end

  test "should destroy Notification" do
    visit admin_notification_url(@admin_notification)
    click_on "Destroy this notification", match: :first

    assert_text "Notification was successfully destroyed"
  end
end
