# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @post    = create(:post)
    @comment = create(:comment, post: @post)
  end

  test 'is valid with valid attributes' do
    assert_predicate @comment, :valid?
  end

  test 'requires a user and post' do
    comment = Comment.new

    assert_not comment.valid?
    assert_includes comment.errors[:user], 'must exist'
    assert_includes comment.errors[:post], 'must exist'
  end

  test 'is invalid with an unknown status' do
    @comment.status = :flagged

    assert_not @comment.valid?
    assert_includes @comment.errors[:status], 'is not included in the list'
  end

  test 'visible returns only published comments' do
    draft = create(:comment, post: @post, status: :draft)

    assert_equal [@comment], Comment.visible.to_a
    assert_not_includes Comment.visible, draft
  end

  test 'touches the post when saved' do
    travel_to 1.hour.from_now do
      create(:comment, post: @post)

      assert_equal Time.current.to_i, @post.reload.updated_at.to_i
    end
  end
end
