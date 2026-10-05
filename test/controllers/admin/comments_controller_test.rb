# frozen_string_literal: true

require 'test_helper'

class Admin::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin   = create(:user, :admin)
    @comment = create(:comment, content: 'Great tips')

    sign_in_as @admin
  end

  test 'renders index, show, new and edit' do
    [admin_comments_path, admin_comment_path(@comment), new_admin_comment_path,
     edit_admin_comment_path(@comment)].each do |path|
      get path

      assert_response :success
    end
  end

  test 'creates a comment' do
    assert_difference 'Comment.count', 1 do
      post admin_comments_path, params: { comment: { content: 'Thanks', post_id: @comment.post_id,
                                                     user_id: @admin.id, status: 'published' } }
    end
  end

  test 'rejects a comment without a post' do
    post admin_comments_path, params: { comment: { content: 'Orphan', user_id: @admin.id } }

    assert_response :unprocessable_content
  end

  test 'moderates a comment' do
    patch admin_comment_path(@comment), params: { comment: { status: 'removed' } }

    assert_redirected_to admin_comment_path(@comment)
    assert_predicate @comment.reload, :removed?
  end

  test 'destroys a comment' do
    assert_difference 'Comment.count', -1 do
      delete admin_comment_path(@comment)
    end
  end
end
