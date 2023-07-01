# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  has_person_name

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :pages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :evaluations, dependent: :destroy

  has_one_attached :avatar

  enum role: { subscriber: 0, contributor: 1, author: 2, editor: 3, admin: 4 }
  enum status: { pending: 0, inactive: 1, active: 2, suspened: 3, blocked: 4 }

  validates :username, uniqueness: true
  validate :acceptable_avatar_image

  private

  def acceptable_avatar_image
    return unless avatar.attached?

    unless avatar.blob.byte_size <= 1.megabyte
      errors.add(:avatar, 'file is too larger than 1Mb')
    end

    acceptable_types = ['image/jpeg', 'image/png']
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, 'must be a JPEG or PNG')
    end
  end

  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end
end
