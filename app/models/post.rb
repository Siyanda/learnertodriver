class Post < ApplicationRecord
  acts_as_votable

  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_presence_of :title

  has_many :comments
  has_many :tags, as: :tagable
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  enum status: { draft: 0, unpublished: 1, published: 2, restricted: 3, removed: 4 }

  scope :most_recent, -> { order(created_at: :desc).limit(5) }

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def generate_excerpt
    # truncate post and strip and save to self.excerpt
  end
end
