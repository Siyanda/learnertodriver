# frozen_string_literal: true

class User < ApplicationRecord
  has_person_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts, dependent: :delete_all
  has_many :pages, dependent: :delete_all

  has_many :comments, dependent: :delete_all
  has_many :evaluations, dependent: :delete_all

  extend FriendlyId
  friendly_id :username, use: :slugged
  validates :username, uniqueness: true

  enum role: { subscriber: 0, contributor: 1, author: 2, editor: 3, admin: 4 }
  enum status: { pending: 0, inactive: 1, active: 2, suspened: 3, blocked: 4 }

  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end
end
