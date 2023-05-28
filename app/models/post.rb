# frozen_string_literal: true

class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_votable

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_one_attached :cover_image
  has_many_attached :images

  enum status: { draft: 0, unpublished: 1, published: 2, restricted: 3, removed: 4 }
  scope :most_recent, -> { order(created_at: :desc).limit(5) }

  before_validation :set_defaults

  validates :title, presence: true
  validates :status, presence: true
  validates :excerpt, length: { maximum: 150 }, allow_blank: true

  private

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def set_defaults
    self.excerpt = ActionView::Base.full_sanitizer.sanitize(content).truncate(150)
  end
end
