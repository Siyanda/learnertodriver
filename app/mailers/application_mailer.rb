# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('DEFAULT_MAIL_FROM', 'hi@learnertodriver.co.za')
  layout 'mailer'
end
