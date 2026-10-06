# frozen_string_literal: true

require 'test_helper'

class GuestUserTest < ActiveSupport::TestCase
  setup do
    @guest_user = GuestUser.new
  end

  test 'is named Guest User' do
    assert_equal 'Guest User', @guest_user.name
  end

  test 'is a guest' do
    assert_predicate @guest_user, :guest?
  end

  test 'has no id' do
    assert_nil @guest_user.id
  end
end
