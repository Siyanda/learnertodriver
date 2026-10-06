# frozen_string_literal: true

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test 'is valid with valid attributes' do
    assert_predicate build(:notification), :valid?
  end

  test 'requires a notifiable' do
    notification = Notification.new

    assert_not notification.valid?
    assert_includes notification.errors[:notifiable], 'must exist'
  end

  test 'belongs to a polymorphic notifiable' do
    page         = create(:page)
    notification = create(:notification, notifiable: page)

    assert_equal page, notification.reload.notifiable
  end
end
