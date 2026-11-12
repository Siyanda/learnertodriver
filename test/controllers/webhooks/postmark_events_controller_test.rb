# frozen_string_literal: true

require 'test_helper'

class Webhooks::PostmarkEventsControllerTest < ActionDispatch::IntegrationTest
  PASSWORD = 'webhook-secret'

  setup do
    @previous_password                = ENV.fetch('POSTMARK_WEBHOOK_PASSWORD', nil)
    ENV['POSTMARK_WEBHOOK_PASSWORD']  = PASSWORD
    @bounce                           = { RecordType: 'Bounce', Type: 'HardBounce', Email: 'gone@example.com',
Inactive: true }
  end

  teardown do
    ENV['POSTMARK_WEBHOOK_PASSWORD'] = @previous_password
  end

  test 'records a hard bounce' do
    post webhooks_postmark_events_path, params: @bounce, as: :json, headers: auth_headers(PASSWORD)

    assert_response :ok
    assert EmailSuppression.exists?(email_address: 'gone@example.com')
  end

  test 'rejects requests with the wrong password' do
    post webhooks_postmark_events_path, params: @bounce, as: :json, headers: auth_headers('wrong')

    assert_response :unauthorized
    assert_not EmailSuppression.exists?(email_address: 'gone@example.com')
  end

  test 'rejects every request while no password is configured' do
    ENV['POSTMARK_WEBHOOK_PASSWORD'] = nil

    post webhooks_postmark_events_path, params: @bounce, as: :json, headers: auth_headers('')

    assert_response :unauthorized
  end

  private

  def auth_headers(password)
    { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials('postmark', password) }
  end
end
