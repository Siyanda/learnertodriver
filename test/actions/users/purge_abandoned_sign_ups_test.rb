# frozen_string_literal: true

require 'test_helper'

class Users::PurgeAbandonedSignUpsTest < ActiveSupport::TestCase
  setup do
    @abandoned = create(:user, confirmed_at: nil, status: :pending, created_at: 8.days.ago)
  end

  test 'deletes old unconfirmed sign-ups' do
    ctx = Users::PurgeAbandonedSignUps.execute

    assert_equal 1, ctx.purged_count
    assert_not User.exists?(@abandoned.id)
  end

  test 'keeps sign-ups that still have time to confirm' do
    recent = create(:user, confirmed_at: nil, status: :pending, created_at: 2.days.ago)

    Users::PurgeAbandonedSignUps.execute

    assert User.exists?(recent.id)
  end

  test 'keeps confirmed users' do
    confirmed = create(:user, status: :pending, created_at: 1.year.ago)

    Users::PurgeAbandonedSignUps.execute

    assert User.exists?(confirmed.id)
  end

  test 'keeps unconfirmed users who have used the app' do
    create(:comment, user: @abandoned)

    Users::PurgeAbandonedSignUps.execute

    assert User.exists?(@abandoned.id)
  end

  test 'keeps users who are not pending' do
    @abandoned.update!(status: :active)

    Users::PurgeAbandonedSignUps.execute

    assert User.exists?(@abandoned.id)
  end
end
