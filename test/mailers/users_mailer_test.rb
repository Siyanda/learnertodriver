# frozen_string_literal: true

require 'test_helper'

class UsersMailerTest < ActionMailer::TestCase
  test 'email confirmation goes to the account address' do
    user = create(:user, confirmed_at: nil, first_name: 'Thandi')

    mail = UsersMailer.email_confirmation(user)

    assert_equal [user.email_address], mail.to
    assert_equal 'Confirm your email address', mail.subject
    assert_match 'Hi Thandi', mail.text_part.body.to_s
    assert_match %r{/confirmations/\S+}, mail.text_part.body.to_s
  end

  test 'email change confirmation goes to the new address' do
    user = create(:user, unconfirmed_email: 'new@example.com')

    mail = UsersMailer.email_confirmation(user)

    assert_equal ['new@example.com'], mail.to
    assert_match 'change your Learner to Driver email address', mail.text_part.body.to_s
  end
end
