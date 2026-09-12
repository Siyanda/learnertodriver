# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @post = create(:post, user: @user)
  end

  test 'belongs to a user' do
    assert_equal @user, @post.user
  end

  test 'has many comments' do
    create(:comment, post: @post)
    create(:comment, post: @post)

    assert_equal 2, @post.comments.count
  end

  test 'destroys associated comments when post is destroyed' do
    create(:comment, post: @post)

    assert_difference 'Comment.count', -1 do
      @post.destroy
    end
  end

  test 'is valid with valid attributes' do
    assert_predicate @post, :valid?
  end

  test 'is invalid without a title' do
    @post.title = nil

    assert_not @post.valid?
    assert_includes @post.errors[:title], "can't be blank"
  end

  test 'is invalid without a status' do
    @post.status = nil

    assert_not @post.valid?
    assert_includes @post.errors[:status], "can't be blank"
  end

  test 'defaults to draft status' do
    post = build(:post, user: @user, status: :draft)

    assert_predicate post, :draft?
  end

  test 'can be set to each valid status' do
    %i[draft unpublished published restricted removed].each do |status|
      @post.status = status

      assert_predicate @post, :"#{status}?"
    end
  end

  test 'most_recent returns up to 5 posts ordered by created_at desc' do
    create_list(:post, 6, user: @user)

    results = Post.most_recent

    assert_equal 5, results.count
    assert_equal Post.order(created_at: :desc).first, results.first
  end

  test 'related_posts returns the author\'s other posts, newest first, excluding self' do
    older_post = create(:post, user: @user, created_at: 3.days.ago)
    newer_post = create(:post, user: @user, created_at: 1.day.ago)
    other_post = create(:post, created_at: 2.hours.ago)

    results = @post.related_posts

    assert_equal [newer_post, older_post], results.to_a
    assert_not_includes results, @post
    assert_not_includes results, other_post
  end

  test 'related_posts includes posts of any status' do
    draft = create(:post, user: @user, status: :draft)
    restricted = create(:post, user: @user, status: :restricted)

    results = @post.related_posts

    assert_includes results, draft
    assert_includes results, restricted
  end

  test 'related_posts respects the limit parameter' do
    create_list(:post, 7, user: @user)

    assert_equal 5, @post.related_posts.length
    assert_equal 3, @post.related_posts(limit: 3).length
  end

  test 'generates a slug from the title' do
    post = create(:post, user: @user, title: 'My First Post')

    assert_equal 'my-first-post', post.slug
  end

  test 'regenerates slug when title changes' do
    @post.update!(title: 'Updated Title')

    assert_equal 'updated-title', @post.slug
  end
end
