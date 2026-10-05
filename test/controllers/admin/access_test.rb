# frozen_string_literal: true

require 'test_helper'

class Admin::AccessTest < ActionDispatch::IntegrationTest
  test 'guests are sent to sign in' do
    get admin_path

    assert_redirected_to new_session_path
  end

  test 'non-admin users are redirected to root' do
    sign_in_as create(:user)

    get admin_users_path

    assert_redirected_to root_path
    assert_equal I18n.t('admin.not_authorized'), flash[:alert]
  end

  test 'admins can access the admin area' do
    sign_in_as create(:user, :admin)

    get admin_path

    assert_response :success
  end
end
