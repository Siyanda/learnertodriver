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

  enum role: { subscriber: 0, contributor: 1, author: 2, editor: 3, admin: 4 }
  enum status: { pending: 0, inactive: 1, active: 2, suspened: 3, blocked: 4 }

  validates :username, uniqueness: true

  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end
end
