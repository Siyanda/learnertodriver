# frozen_string_literal: true

require 'test_helper'

class User::AvatarComponentTest < ViewComponent::TestCase
  include ActionDispatch::TestProcess::FixtureFile

  def test_renders_gravatar_when_no_avatar_attached
    user = create(:user, email_address: 'sadio@example.com')

    component = render_inline(User::AvatarComponent.new(user: user))

    hash = Digest::MD5.hexdigest('sadio@example.com')
    assert_equal "https://www.gravatar.com/avatar/#{hash}?s=80&d=identicon", component.css('img').first['src']
  end

  def test_renders_custom_size_in_gravatar_url
    user = create(:user, email_address: 'sadio@example.com')

    component = render_inline(User::AvatarComponent.new(user: user, size: 200))

    assert_includes component.css('img').first['src'], 's=200'
  end

  def test_renders_custom_html_class
    user = create(:user)

    component = render_inline(User::AvatarComponent.new(user: user, html_class: 'rounded shadowed'))

    assert_equal 'rounded shadowed', component.css('img').first['class']
  end
end
