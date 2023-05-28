# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'generates new slug when username is updated' do
    u = create(:user, username: nil)
    u.username = 'sadiomane'
    u.save

    assert_equal u.slug, 'sadiomane'
  end
end
