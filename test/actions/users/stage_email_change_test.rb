# frozen_string_literal: true

require 'test_helper'

class Users::StageEmailChangeTest < ActiveSupport::TestCase
  setup { @user = create(:user, email_address: 'me@example.com') }

  test 'stages a new address instead of changing it' do
    ctx = stage(email_address: ' New@Example.com ')

    assert ctx.email_change_requested
    assert_equal({ 'title' => 'Learner', 'unconfirmed_email' => 'new@example.com' }, ctx.attributes.to_h)
  end

  test 'ignores an unchanged address' do
    ctx = stage(email_address: 'me@example.com')

    assert_not ctx.email_change_requested
    assert_nil ctx.attributes[:unconfirmed_email]
  end

  test 'cancels a pending change when the current address is entered again' do
    @user.update!(unconfirmed_email: 'pending@example.com')

    ctx = stage(email_address: 'me@example.com')

    assert_not ctx.email_change_requested
    assert ctx.attributes.key?(:unconfirmed_email)
    assert_nil ctx.attributes[:unconfirmed_email]
  end

  test 'does not resend for the same pending address' do
    @user.update!(unconfirmed_email: 'pending@example.com')

    assert_not stage(email_address: 'pending@example.com').email_change_requested
  end

  private

  def stage(**attributes)
    params = ActionController::Parameters.new(attributes.merge(title: 'Learner')).permit!
    Users::StageEmailChange.execute(user: @user, attributes: params)
  end
end
