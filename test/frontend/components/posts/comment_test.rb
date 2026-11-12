# frozen_string_literal: true

require 'test_helper'

class Posts::Comment::ComponentTest < ViewComponent::TestCase
  def test_renders_comment_count
    post = create(:post)
    create_list(:comment, 2, post: post)

    with_request_url "/posts/#{post.id}" do
      render_inline(Posts::Comment::Component.new(post: post))
    end

    assert_selector '.comments-title', text: '2 Comments'
  end

  def test_hides_comments_awaiting_approval
    post = create(:post)
    create(:comment, post: post, status: :draft, content: 'Spam link')

    with_request_url "/posts/#{post.id}" do
      render_inline(Posts::Comment::Component.new(post: post))
    end

    assert_selector '.comments-title', text: '0 Comments'
    assert_no_text 'Spam link'
  end

  def test_renders_no_comments_message
    post = create(:post)

    with_request_url "/posts/#{post.id}" do
      render_inline(Posts::Comment::Component.new(post: post))
    end

    assert_selector '.comment-header h4', text: I18n.t('comments.none')
  end

  def test_renders_comment_content
    post = create(:post)
    comment = create(:comment, post: post)

    with_request_url "/posts/#{post.id}" do
      render_inline(Posts::Comment::Component.new(post: post))
    end

    assert_selector '.comment-content p', text: comment.content
  end
end
