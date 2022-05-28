class Post < ApplicationRecord
  after_initialize :set_defaults

  extend FriendlyId

  acts_as_votable

  friendly_id :title, use: :slugged
  validates :title, presence: true

  # has_one_attached :cover_image

  has_many :comments
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  belongs_to :author, class_name: 'User'

  enum status: { draft: 0, unpublished: 1, published: 2, restricted: 3, removed: 4 }
  scope :most_recent, -> { order(created_at: :desc).limit(5) }

  private

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def set_defaults
    self.excerpt ||= ActionView::Base.full_sanitizer.sanitize(content).truncate(150)
  end
end
