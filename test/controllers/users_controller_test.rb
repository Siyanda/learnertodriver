# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  setup do
    @user = create(:user, first_name: 'Thandi', last_name: 'Nkosi', username: 'thandi',
                          bio: 'Learning to drive', links: "https://example.com\njavascript:alert(1)")
  end

  test 'guests are sent to sign in' do
    get user_path

    assert_redirected_to new_session_path
  end

  test 'shows the profile' do
    create(:comment, user: @user)
    sign_in_as @user

    get user_path

    assert_response :success
    assert_select 'h1', text: 'Thandi Nkosi'
    assert_select '.stat-card', text: /Comments\s*1/
    assert_select '.profile-links a[href="https://example.com"]', text: 'example.com'
    assert_select '.profile-links a[href^="javascript"]', count: 0
    assert_select "a[href='#{edit_user_path}']", text: 'Edit profile'
  end

  test 'renders the edit form' do
    sign_in_as @user

    get edit_user_path

    assert_response :success
    assert_select "form[action='#{user_path}'] input[name='user[first_name]'][value='Thandi']"
  end

  test 'updates the profile' do
    sign_in_as @user

    patch user_path, params: { user: { title: 'Learner driver', birthday: '2004-02-29',
                                       avatar: fixture_file_upload('avatar.jpg', 'image/jpeg') } }

    assert_redirected_to user_path
    @user.reload

    assert_equal 'Learner driver', @user.title
    assert_equal Date.new(2004, 2, 29), @user.birthday
    assert_predicate @user.avatar, :attached?
  end

  test 'changing the email waits for confirmation' do
    sign_in_as @user
    current = @user.email_address

    assert_enqueued_emails 1 do
      patch user_path, params: { user: { email_address: 'thandi.new@example.com' } }
    end

    @user.reload

    assert_equal current, @user.email_address
    assert_equal 'thandi.new@example.com', @user.unconfirmed_email
    assert_match 'thandi.new@example.com', flash[:notice]
  end

  test 'cannot change the email to one that is taken' do
    taken = create(:user)
    sign_in_as @user

    patch user_path, params: { user: { email_address: taken.email_address } }

    assert_response :unprocessable_content
    assert_nil @user.reload.unconfirmed_email
  end

  test 'shows a banner until the email is confirmed' do
    @user.update!(confirmed_at: nil)
    sign_in_as @user

    get user_path

    assert_select '.confirmation-banner button', text: 'Resend email'
    assert_select '.status-badge', text: 'Unconfirmed'
  end

  test 'profile pages use the signed-in layout' do
    sign_in_as @user

    [user_path, edit_user_path, edit_user_password_path].each do |path|
      get path

      assert_select 'nav.top-nav', 1, "expected the user navigation on #{path}"
    end
  end

  test 'links to change password' do
    sign_in_as @user

    get user_path

    assert_select "a[href='#{edit_user_password_path}']", text: 'Change password'
    assert_select '.confirmation-banner', count: 0
  end

  test 'does not allow changing the role' do
    sign_in_as @user

    patch user_path, params: { user: { role: 'admin', title: 'Sneaky' } }

    assert_predicate @user.reload, :subscriber?
  end

  test 're-renders the form when invalid' do
    taken = create(:user)
    sign_in_as @user

    patch user_path, params: { user: { username: taken.username } }

    assert_response :unprocessable_content
    assert_select '#error_explanation'
    assert_equal 'thandi', @user.reload.username
  end

  test 'rejects a non-image avatar' do
    sign_in_as @user

    patch user_path, params: { user: { avatar: fixture_file_upload('fake.txt', 'text/plain') } }

    assert_response :unprocessable_content
    assert_not @user.reload.avatar.attached?
  end
end
