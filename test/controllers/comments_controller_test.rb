# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = create(:post)
  end

  test 'confirmed users can comment' do
    sign_in_as create(:user)

    assert_difference 'Comment.count', 1 do
      post post_comments_path(@post), params: { comment: { content: 'Great tips' } }
    end

    assert_redirected_to post_path(@post)
    assert_predicate Comment.last, :draft?
  end

  test 'new comments stay hidden until approved' do
    sign_in_as create(:user)

    post post_comments_path(@post), params: { comment: { content: 'Awaiting approval' } }
    follow_redirect!

    assert_equal I18n.t('comments.create.awaiting_approval'), flash[:notice]
    assert_select '.comment-content', text: /Awaiting approval/, count: 0
  end

  test 'unconfirmed users must confirm their email before commenting' do
    sign_in_as create(:user, confirmed_at: nil)

    assert_no_difference 'Comment.count' do
      post post_comments_path(@post), params: { comment: { content: 'Buy cheap stuff' } }
    end

    assert_equal I18n.t('comments.confirm_email_first'), flash[:alert]
  end
end
