require "test_helper"

class Admin::FriendlyIdSlugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_friendly_id_slug = admin_friendly_id_slugs(:one)
  end

  test "should get index" do
    get admin_friendly_id_slugs_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_friendly_id_slug_url
    assert_response :success
  end

  test "should create admin_friendly_id_slug" do
    assert_difference("Admin::FriendlyIdSlug.count") do
      post admin_friendly_id_slugs_url, params: { admin_friendly_id_slug: { scope: @admin_friendly_id_slug.scope, slug: @admin_friendly_id_slug.slug, sluggable_id: @admin_friendly_id_slug.sluggable_id, sluggable_type: @admin_friendly_id_slug.sluggable_type } }
    end

    assert_redirected_to admin_friendly_id_slug_url(Admin::FriendlyIdSlug.last)
  end

  test "should show admin_friendly_id_slug" do
    get admin_friendly_id_slug_url(@admin_friendly_id_slug)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_friendly_id_slug_url(@admin_friendly_id_slug)
    assert_response :success
  end

  test "should update admin_friendly_id_slug" do
    patch admin_friendly_id_slug_url(@admin_friendly_id_slug), params: { admin_friendly_id_slug: { scope: @admin_friendly_id_slug.scope, slug: @admin_friendly_id_slug.slug, sluggable_id: @admin_friendly_id_slug.sluggable_id, sluggable_type: @admin_friendly_id_slug.sluggable_type } }
    assert_redirected_to admin_friendly_id_slug_url(@admin_friendly_id_slug)
  end

  test "should destroy admin_friendly_id_slug" do
    assert_difference("Admin::FriendlyIdSlug.count", -1) do
      delete admin_friendly_id_slug_url(@admin_friendly_id_slug)
    end

    assert_redirected_to admin_friendly_id_slugs_url
  end
end
