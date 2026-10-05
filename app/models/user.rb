# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId

  friendly_id :username, use: :slugged

  has_secure_password
  has_person_name

  has_many :sessions,    dependent: :destroy
  has_many :posts,       dependent: :destroy
  has_many :pages,       dependent: :destroy
  has_many :comments,    dependent: :destroy
  has_many :evaluations, dependent: :destroy

  has_one_attached :avatar

  enum :role, { subscriber: 0, contributor: 1, author: 2, editor: 3, admin: 4 }, validate: true
  enum :status, { pending: 0, inactive: 1, active: 2, suspened: 3, blocked: 4 }, validate: true

  normalizes :email_address, :unconfirmed_email, with: ->(e) { e.strip.downcase }

  # Single use: the token changes once the email is confirmed or replaced.
  generates_token_for :email_confirmation, expires_in: 2.days do
    [email_address, unconfirmed_email, confirmed_at&.to_i]
  end

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username,      presence: true, uniqueness: true
  validates :unconfirmed_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validate  :unconfirmed_email_available
  validate :acceptable_avatar_image

  def self.ransackable_attributes(_auth_object = nil)
    %w[first_name last_name username email_address role status created_at last_sign_in_at]
  end

  def self.ransackable_associations(_auth_object = nil) = []

  def should_generate_new_friendly_id? = slug.blank? || username_changed?

  def confirmed? = confirmed_at.present?

  def pending_reconfirmation? = unconfirmed_email.present?

  # The address a confirmation email should go to.
  def confirmation_email = unconfirmed_email.presence || email_address

  private

  def unconfirmed_email_available
    return if unconfirmed_email.blank?
    return unless User.where.not(id:).exists?(email_address: unconfirmed_email)

    errors.add(:email_address, :taken)
  end

  def acceptable_avatar_image
    return unless avatar.attached?

    errors.add(:avatar, 'file is too large, the maximum is 4Mb') unless avatar.blob.byte_size <= 4.megabytes

    acceptable_types = ['image/jpeg', 'image/png']
    return if acceptable_types.include?(avatar.content_type)

    errors.add(:avatar, 'must be a JPEG or PNG')
  end
end
