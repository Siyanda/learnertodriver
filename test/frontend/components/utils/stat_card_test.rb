# frozen_string_literal: true

require 'test_helper'

class Utils::StatCard::ComponentTest < ViewComponent::TestCase
  def test_renders_label_and_value
    render_inline(Utils::StatCard::Component.new(label: 'Users', value: 42))

    assert_selector '.stat-card p', text: 'Users'
    assert_selector '.stat-card h1', text: '42'
    assert_no_selector '.stat-card a'
    assert_no_selector '.stat-change'
  end

  def test_links_value_when_path_given
    render_inline(Utils::StatCard::Component.new(label: 'Users', value: 42, icon: 'icons/user.svg',
                                                 path: '/admin/users'))

    assert_selector '.stat-card h1 a[href="/admin/users"]', text: '42'
    assert_selector '.stat-card svg'
  end

  def test_renders_change_with_direction
    render_inline(Utils::StatCard::Component.new(label: 'Users', value: 42, change: -12, change_label: 'vs last month'))

    assert_selector '.stat-change .down', text: '-12%'
    assert_selector '.stat-change', text: 'vs last month'
  end
end
