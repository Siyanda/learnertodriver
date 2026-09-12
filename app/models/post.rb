# frozen_string_literal: true

class Post < ApplicationRecord
  extend FriendlyId

  friendly_id :title, use: :slugged

  broadcasts_refreshes

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy

  has_many :tags, through: :taggings

  has_one_attached  :cover_image
  has_many_attached :images

  enum :status, {
    draft:       0,
    unpublished: 1,
    published:   2,
    restricted:  3,
    removed:     4
  }, validate: true

  scope :most_recent, -> { order(created_at: :desc).limit(5) }

  validates :title,  presence: true
  validates :status, presence: true

  def related(limit: 5) = user.posts.where.not(id:).order(created_at: :desc).limit(limit)

  def should_generate_new_friendly_id? = slug.blank? || title_changed?
end
