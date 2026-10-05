# frozen_string_literal: true

require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = create(:user, :admin)
    @user  = create(:user, first_name: 'Thembi', username: 'thembi')

    sign_in_as @admin
  end

  test 'lists and searches users' do
    get admin_users_path, params: { q: { first_name_or_last_name_or_username_or_email_address_cont: 'thembi' } }

    assert_response :success
    assert_select "#user_#{@user.id}"
    assert_select "#user_#{@admin.id}", count: 0
  end

  test 'renders show, new and edit' do
    get admin_user_path(@user)

    assert_response :success

    get new_admin_user_path

    assert_response :success

    get edit_admin_user_path(@user)

    assert_response :success
  end

  test 'creates a user' do
    assert_difference 'User.count', 1 do
      post admin_users_path, params: { user: user_params }
    end

    user = User.find_by!(username: 'newbie')

    assert_redirected_to admin_user_path(user)
    assert_predicate user, :confirmed?
  end

  test 'rejects an invalid user' do
    assert_no_difference 'User.count' do
      post admin_users_path, params: { user: user_params.merge(password: '') }
    end

    assert_response :unprocessable_content
  end

  test 'updates a user without changing the password' do
    digest = @user.password_digest

    patch admin_user_path(@user), params: { user: { role: 'editor', password: '', password_confirmation: '' } }

    assert_redirected_to admin_user_path(@user.reload)
    assert_predicate @user, :editor?
    assert_equal digest, @user.password_digest
  end

  test 'destroys a user' do
    assert_difference 'User.count', -1 do
      delete admin_user_path(@user)
    end

    assert_redirected_to admin_users_path
  end

  test 'does not let an admin destroy themselves' do
    assert_no_difference 'User.count' do
      delete admin_user_path(@admin)
    end

    assert_redirected_to admin_user_path(@admin)
  end

  private

  def user_params
    {
      first_name:            'New',
      last_name:             'User',
      username:              'newbie',
      email_address:         'newbie@example.com',
      role:                  'subscriber',
      status:                'active',
      password:              'secret123',
      password_confirmation: 'secret123'
    }
  end
end
