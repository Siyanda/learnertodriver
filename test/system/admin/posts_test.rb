require "application_system_test_case"

class Admin::PostsTest < ApplicationSystemTestCase
  setup do
    @admin_post = admin_posts(:one)
  end

  test "visiting the index" do
    visit admin_posts_url
    assert_selector "h1", text: "Posts"
  end

  test "should create post" do
    visit admin_posts_url
    click_on "New post"

    fill_in "Content", with: @admin_post.content
    fill_in "Excerpt", with: @admin_post.excerpt
    fill_in "Published at", with: @admin_post.published_at
    fill_in "Slug", with: @admin_post.slug
    fill_in "Status", with: @admin_post.status
    fill_in "Title", with: @admin_post.title
    fill_in "User", with: @admin_post.user_id
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "should update Post" do
    visit admin_post_url(@admin_post)
    click_on "Edit this post", match: :first

    fill_in "Content", with: @admin_post.content
    fill_in "Excerpt", with: @admin_post.excerpt
    fill_in "Published at", with: @admin_post.published_at.to_s
    fill_in "Slug", with: @admin_post.slug
    fill_in "Status", with: @admin_post.status
    fill_in "Title", with: @admin_post.title
    fill_in "User", with: @admin_post.user_id
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "should destroy Post" do
    visit admin_post_url(@admin_post)
    click_on "Destroy this post", match: :first

    assert_text "Post was successfully destroyed"
  end
end
