# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'shows a readable error for a wrong password' do
    user = create(:user)

    post session_path, params: { email_address: user.email_address, password: 'wrong' }

    assert_redirected_to new_session_path
    assert_equal I18n.t('sessions.create.email_password_mismatch'), flash[:alert]
  end

  test 'links to sign up' do
    get new_session_path

    assert_select "a[href='#{new_user_path}']", text: /Sign up/
  end
end
