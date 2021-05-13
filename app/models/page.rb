class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_presence_of :title

  belongs_to :parent, class_name: 'Page', optional: true
  has_many :children, class_name: 'Page', foreign_key: :parent_id, dependent: :delete_all

  belongs_to :editor, class_name: 'User', foreign_key: 'editor_id'

  enum status: { draft: 0, unpublished: 1, published: 2, restricted: 3, removed: 4 }

  def should_generate_new_friendly_id?
    slug.blank? || slug_changed?
  end
end
