# frozen_string_literal: true

require 'test_helper'

class EmailSuppressions::RecordPostmarkEventTest < ActiveSupport::TestCase
  test 'suppresses an address Postmark deactivated after a hard bounce' do
    EmailSuppressions::RecordPostmarkEvent.execute(record_type: 'Bounce', email_address: 'gone@example.com',
                                                   inactive: true)

    assert_predicate EmailSuppression.find_by!(email_address: 'gone@example.com'), :hard_bounce?
  end

  test 'suppresses an address that sent a spam complaint' do
    EmailSuppressions::RecordPostmarkEvent.execute(record_type: 'SpamComplaint', email_address: 'angry@example.com',
                                                   inactive: true)

    assert_predicate EmailSuppression.find_by!(email_address: 'angry@example.com'), :spam_complaint?
  end

  test 'ignores soft bounces Postmark keeps active' do
    assert_no_difference 'EmailSuppression.count' do
      EmailSuppressions::RecordPostmarkEvent.execute(record_type: 'Bounce', email_address: 'full@example.com',
                                                     inactive: false)
    end
  end

  test 'ignores other event types' do
    assert_no_difference 'EmailSuppression.count' do
      EmailSuppressions::RecordPostmarkEvent.execute(record_type: 'Delivery', email_address: 'ok@example.com',
                                                     inactive: true)
    end
  end

  test 'does not duplicate an existing suppression' do
    create(:email_suppression, email_address: 'gone@example.com')

    assert_no_difference 'EmailSuppression.count' do
      EmailSuppressions::RecordPostmarkEvent.execute(record_type: 'Bounce', email_address: 'Gone@Example.com',
                                                     inactive: true)
    end
  end
end
