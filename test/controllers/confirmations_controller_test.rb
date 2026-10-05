# frozen_string_literal: true

require 'test_helper'

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  setup do
    @user = create(:user, confirmed_at: nil, status: :pending)
  end

  test 'confirms a new account' do
    get confirmation_path(@user.generate_token_for(:email_confirmation))

    assert_redirected_to new_session_path
    assert_predicate @user.reload, :confirmed?
    assert_predicate @user, :active?
  end

  test 'confirmation links only work once' do
    token = @user.generate_token_for(:email_confirmation)
    get confirmation_path(token)

    get confirmation_path(token)

    assert_redirected_to new_confirmation_path
    assert_equal I18n.t('confirmations.show.invalid'), flash[:alert]
  end

  test 'rejects an invalid token' do
    get confirmation_path('nope')

    assert_redirected_to new_confirmation_path
    assert_not @user.reload.confirmed?
  end

  test 'swaps in a changed email address once it is confirmed' do
    user = create(:user, email_address: 'old@example.com', unconfirmed_email: 'new@example.com')
    sign_in_as user

    get confirmation_path(user.generate_token_for(:email_confirmation))

    assert_redirected_to user_path
    user.reload

    assert_equal 'new@example.com', user.email_address
    assert_nil user.unconfirmed_email
  end

  test 'a confirmation link stops working if the pending email changes again' do
    user  = create(:user, unconfirmed_email: 'first@example.com')
    token = user.generate_token_for(:email_confirmation)
    user.update!(unconfirmed_email: 'second@example.com')

    get confirmation_path(token)

    assert_equal 'second@example.com', user.reload.unconfirmed_email
  end

  test 'resends a confirmation link by email address' do
    assert_enqueued_email_with UsersMailer, :email_confirmation, args: [@user] do
      post confirmations_path, params: { email_address: @user.email_address }
    end

    assert_redirected_to new_session_path
  end

  test 'does not reveal whether an email address exists' do
    assert_no_enqueued_emails do
      post confirmations_path, params: { email_address: 'nobody@example.com' }
    end

    assert_equal I18n.t('confirmations.create.sent'), flash[:notice]
  end

  test 'does not email already-confirmed users' do
    confirmed = create(:user)

    assert_no_enqueued_emails do
      post confirmations_path, params: { email_address: confirmed.email_address }
    end
  end

  test 'resends to the signed-in user from the banner' do
    sign_in_as @user

    assert_enqueued_email_with UsersMailer, :email_confirmation, args: [@user] do
      post confirmations_path
    end
  end
end
