# frozen_string_literal: true

class Interceptors::SuppressedRecipients
  def self.delivering_email(message)
    suppressed = EmailSuppression.where(email_address: Array(message.to)).pluck(:email_address)
    return if suppressed.empty?

    message.to                 = Array(message.to).map(&:downcase) - suppressed
    message.perform_deliveries = false if message.to.blank?
  end
end
