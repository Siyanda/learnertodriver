# frozen_string_literal: true

require 'test_helper'

class Admin::Table::ComponentTest < ViewComponent::TestCase
  def test_links_records_and_associations
    post = render_posts_table

    assert_selector "tr#post_#{post.id} a[href='/admin/posts/#{post.slug}']", text: 'Merging lanes'
    assert_selector "tr#post_#{post.id} a[href='/admin/users/#{post.user.slug}']"
    assert_selector "a[href='/admin/posts/#{post.slug}/edit']"
  end

  def test_formats_enums_and_sortable_headers
    render_posts_table

    assert_selector '.status-badge.draft', text: 'Draft'
    assert_selector 'th a.sort-link', text: 'Title'
  end

  def test_renders_empty_state_without_actions
    render_inline(Admin::Table::Component.new(records: Tag.none, columns: %i[title], actions: []))

    assert_text 'No records found'
    assert_no_selector 'form'
  end

  private

  def render_posts_table
    create(:post, title: 'Merging lanes', status: :draft).tap do
      with_request_url '/admin/posts' do
        render_inline(Admin::Table::Component.new(records: Post.all, columns: %i[title user status],
                                                  search:  Post.ransack))
      end
    end
  end
end
