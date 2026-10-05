# frozen_string_literal: true

require 'test_helper'

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = create(:user, :admin)
    @post  = create(:post)
    @tag   = create(:tag)

    sign_in_as @admin
  end

  test 'renders index, show, new and edit' do
    [admin_posts_path, admin_post_path(@post), new_admin_post_path, edit_admin_post_path(@post)].each do |path|
      get path

      assert_response :success
    end
  end

  test 'filters by status' do
    draft = create(:post, status: :draft)

    get admin_posts_path, params: { q: { status_eq: Post.statuses[:draft] } }

    assert_select "#post_#{draft.id}"
    assert_select "#post_#{@post.id}", count: 0
  end

  test 'creates a post with tags' do
    assert_difference 'Post.count', 1 do
      post admin_posts_path, params: { post: { title: 'Merging lanes', user_id: @admin.id, status: 'draft',
                                               tag_ids: [@tag.id] } }
    end

    post_record = Post.order(:id).last

    assert_redirected_to admin_post_path(post_record)
    assert_equal [@tag], post_record.tags.to_a
  end

  test 'rejects an invalid post' do
    assert_no_difference 'Post.count' do
      post admin_posts_path, params: { post: { title: '', user_id: @admin.id } }
    end

    assert_response :unprocessable_content
  end

  test 'updates a post' do
    patch admin_post_path(@post), params: { post: { status: 'removed' } }

    assert_redirected_to admin_post_path(@post.reload)
    assert_predicate @post, :removed?
  end

  test 'destroys a post' do
    assert_difference 'Post.count', -1 do
      delete admin_post_path(@post)
    end

    assert_redirected_to admin_posts_path
  end
end
