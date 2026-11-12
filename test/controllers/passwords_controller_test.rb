# frozen_string_literal: true

require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  setup do
    @user = create(:user)
  end

  test 'renders the bot check on the reset form' do
    get new_password_path

    assert_select "form[action='#{passwords_path}'] input[name='form_started_at']"
  end

  test 'emails reset instructions' do
    assert_enqueued_email_with PasswordsMailer, :reset, args: [@user] do
      post passwords_path, params: { email_address: " #{@user.email_address.upcase} ", **bot_check_params }
    end

    assert_redirected_to new_session_path
  end

  test 'does not email when the bot check fails' do
    assert_no_enqueued_emails do
      post passwords_path, params: { email_address: @user.email_address, website: 'spam', **bot_check_params }
    end

    assert_redirected_to new_password_path
    assert_equal I18n.t('bot_checks.failed'), flash[:alert]
  end
end
