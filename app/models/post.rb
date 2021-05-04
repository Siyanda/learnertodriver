class Post < ApplicationRecord
  acts_as_votable

  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_presence_of :title

  has_many :comments
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_rich_text :content
  has_one_attached :cover_image
  has_many_attached :images

  enum status: { draft: 0, unpublished: 1, published: 2, restricted: 3, removed: 4 }
  scope :is_published, -> { where(status: 'published') }

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
