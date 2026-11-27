# frozen_string_literal: true

class FlaggedIp < ApplicationRecord
  enum :reason, { honeypot: 10, too_fast: 20 }, validate: true

  validates :ip_address, presence: true, uniqueness: true

  def self.flag(ip_address:, reason:)
    find_or_create_by!(ip_address:) { |flagged_ip| flagged_ip.reason = reason }
  rescue ActiveRecord::RecordNotUnique
    find_by!(ip_address:)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[ip_address reason created_at]
  end

  def self.ransackable_associations(_auth_object = nil) = []

  def name = ip_address
end
