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

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :username, uniqueness: true
  validate :acceptable_avatar_image

  def should_generate_new_friendly_id? = slug.blank? || username_changed?

  private

  def acceptable_avatar_image
    return unless avatar.attached?

    errors.add(:avatar, 'file is too large, the maximum is 4Mb') unless avatar.blob.byte_size <= 4.megabytes

    acceptable_types = ['image/jpeg', 'image/png']
    return if acceptable_types.include?(avatar.content_type)

    errors.add(:avatar, 'must be a JPEG or PNG')
  end
end
