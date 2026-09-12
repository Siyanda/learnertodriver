# frozen_string_literal: true

require 'test_helper'

class Posts::Content::ComponentTest < ViewComponent::TestCase
  def test_renders_title
    post = create(:post, title: 'My Post Title')

    render_inline(Posts::Content::Component.new(post: post))

    assert_selector '.post-title', text: 'My Post Title'
  end

  def test_renders_markdown_body
    post = create(:post, content: '**bold** content')

    render_inline(Posts::Content::Component.new(post: post))

    assert_selector '.post-body strong', text: 'bold'
  end

  def test_renders_posted_at
    post = create(:post)

    render_inline(Posts::Content::Component.new(post: post))

    assert_selector '.post-date', text: I18n.t('posts.posted_at')
  end
end
