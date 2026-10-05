# frozen_string_literal: true

require 'test_helper'

class Users::SignUpTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  setup do
    @user = create(:user)
  end

  test 'guests can see the sign-up form' do
    get new_user_path

    assert_response :success
    assert_select "form[action='#{user_path}'] input[name='user[password_confirmation]']"
  end

  test 'signing up creates a subscriber and signs them in' do
    assert_difference 'User.count', 1 do
      post user_path, params: { user: sign_up_params.merge(role: 'admin') }
    end

    user = User.find_by!(email_address: 'lerato@example.com')

    assert_redirected_to dashboard_path
    assert_predicate user, :subscriber?
    assert_predicate user, :pending?
    assert_not user.confirmed?
    assert_enqueued_email_with UsersMailer, :email_confirmation, args: [user]
    assert_equal user.id, Session.order(:id).last.user_id
  end

  test 'sign-up re-renders the form with errors' do
    assert_no_difference 'User.count' do
      post user_path, params: { user: sign_up_params.merge(email_address: @user.email_address) }
    end

    assert_response :unprocessable_content
    assert_select '#error_explanation li', text: /Email address has already been taken/
  end

  test 'signed-in users skip sign-up' do
    sign_in_as @user

    get new_user_path

    assert_redirected_to dashboard_path
  end

  private

  def sign_up_params
    { first_name: 'Lerato', last_name: 'Dlamini', username: 'lerato', email_address: 'lerato@example.com',
      password: 'secret123', password_confirmation: 'secret123' }
  end
end
