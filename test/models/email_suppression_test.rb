# frozen_string_literal: true

require 'test_helper'

class EmailSuppressionTest < ActiveSupport::TestCase
  test 'requires a unique email address' do
    create(:email_suppression, email_address: 'gone@example.com')

    suppression = build(:email_suppression, email_address: 'Gone@Example.com')

    assert_not suppression.valid?
    assert_includes suppression.errors[:email_address], 'has already been taken'
  end

  test 'normalizes the email address' do
    assert_equal 'learner@example.com', build(:email_suppression, email_address: ' Learner@Example.com ').email_address
  end
end
