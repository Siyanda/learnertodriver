class Tag < ApplicationRecord
  extend FriendlyId

  belongs_to :tagable, polymorphic: true

  friendly_id :title, use: :slugged
  validates_presence_of :title

  enum status: { draft: 0, unpublished: 1, published: 2, restricted: 3, removed: 4 }
end
