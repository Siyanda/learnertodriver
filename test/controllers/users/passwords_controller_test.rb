# frozen_string_literal: true

require 'test_helper'

class Users::PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, password: 'old-password')
    sign_in_as @user
  end

  test 'renders the form' do
    get edit_user_password_path

    assert_response :success
    assert_select "input[name='user[current_password]']"
  end

  test 'changes the password and signs out other sessions' do
    other_session = @user.sessions.create!

    patch user_password_path, params: password_params

    assert_redirected_to user_path
    assert @user.reload.authenticate('new-password')
    assert_not Session.exists?(other_session.id)
    assert Session.exists?(Current.session.id)
  end

  test 'requires the current password' do
    patch user_password_path, params: password_params(current_password: 'wrong')

    assert_response :unprocessable_content
    assert_select '#error_explanation', text: /Password challenge is invalid/
    assert @user.reload.authenticate('old-password')
  end

  test 'requires a new password' do
    patch user_password_path, params: password_params(password: '', password_confirmation: '')

    assert_response :unprocessable_content
    assert @user.reload.authenticate('old-password')
  end

  test 'requires the confirmation to match' do
    patch user_password_path, params: password_params(password_confirmation: 'different')

    assert_response :unprocessable_content
    assert @user.reload.authenticate('old-password')
  end

  private

  def password_params(**overrides)
    { user: { current_password:      'old-password',
              password:              'new-password',
              password_confirmation: 'new-password' }.merge(overrides) }
  end
end
