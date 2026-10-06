# frozen_string_literal: true

require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  test 'is valid with valid attributes' do
    assert_predicate build(:session), :valid?
  end

  test 'requires a user' do
    session = Session.new

    assert_not session.valid?
    assert_includes session.errors[:user], 'must exist'
  end

  test 'is destroyed when its user is destroyed' do
    session = create(:session)

    assert_difference 'Session.count', -1 do
      session.user.destroy
    end
  end
end
