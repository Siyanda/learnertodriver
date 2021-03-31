class User < ApplicationRecord
  has_person_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts, foreign_key: 'author_id'
  has_many :notifications, as: :recipient

  has_many :comments
  has_many :evaluations

  extend FriendlyId
  friendly_id :username, use: :slugged

  validates_uniqueness_of :username

  has_one_attached :avatar_image

  enum status: { pending: 0, inactive: 1, active: 2, suspened: 3, blocked: 4 }
  scope :is_active, -> { where(status: 'active') }

  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end

  private

  # TODO: check if username exists if true, suggest a similarname
  # TODO: add Guest user option
  def suggest_username
    # before save ?
  end
end
