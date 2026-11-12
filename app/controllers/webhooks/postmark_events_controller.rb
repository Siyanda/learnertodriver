# frozen_string_literal: true

class Webhooks::PostmarkEventsController < ApplicationController
  WEBHOOK_USERNAME = 'postmark'

  allow_unauthenticated_access
  skip_forgery_protection

  before_action :authenticate_postmark

  def create
    ::EmailSuppressions::RecordPostmarkEvent.execute(
      record_type:   postmark_event_params[:RecordType],
      email_address: postmark_event_params[:Email],
      inactive:      postmark_event_params[:Inactive]
    )

    head :ok
  end

  private

  def authenticate_postmark
    password = ENV.fetch('POSTMARK_WEBHOOK_PASSWORD', nil)
    return head(:unauthorized) if password.blank?

    authenticate_or_request_with_http_basic do |given_username, given_password|
      given_username == WEBHOOK_USERNAME && ActiveSupport::SecurityUtils.secure_compare(given_password, password)
    end
  end

  def postmark_event_params
    params.permit(:RecordType, :Email, :Inactive)
  end
end
