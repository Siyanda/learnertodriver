# frozen_string_literal: true

class EmailSuppression < ApplicationRecord
  enum :reason, { hard_bounce: 10, spam_complaint: 20 }, validate: true

  normalizes :email_address, with: ->(email) { email.strip.downcase }

  validates :email_address, presence: true, uniqueness: true
end
