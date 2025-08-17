require "application_system_test_case"

class Admin::CommentsTest < ApplicationSystemTestCase
  setup do
    @admin_comment = admin_comments(:one)
  end

  test "visiting the index" do
    visit admin_comments_url
    assert_selector "h1", text: "Comments"
  end

  test "should create comment" do
    visit admin_comments_url
    click_on "New comment"

    fill_in "Content", with: @admin_comment.content
    fill_in "Post", with: @admin_comment.post_id
    fill_in "Status", with: @admin_comment.status
    fill_in "User", with: @admin_comment.user_id
    click_on "Create Comment"

    assert_text "Comment was successfully created"
    click_on "Back"
  end

  test "should update Comment" do
    visit admin_comment_url(@admin_comment)
    click_on "Edit this comment", match: :first

    fill_in "Content", with: @admin_comment.content
    fill_in "Post", with: @admin_comment.post_id
    fill_in "Status", with: @admin_comment.status
    fill_in "User", with: @admin_comment.user_id
    click_on "Update Comment"

    assert_text "Comment was successfully updated"
    click_on "Back"
  end

  test "should destroy Comment" do
    visit admin_comment_url(@admin_comment)
    click_on "Destroy this comment", match: :first

    assert_text "Comment was successfully destroyed"
  end
end
