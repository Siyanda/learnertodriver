# frozen_string_literal: true

class Tag < ApplicationRecord
  extend FriendlyId

  has_many :posts, through: :taggings, source: :taggable,
                   source_type: 'Post'

  has_many :quizzes, through: :taggings, source: :taggable,
                     source_type: 'Quiz'

  friendly_id :title, use: :slugged
  enum status: { published: 0, unpublished: 1, restricted: 2, removed: 3 }

  validates :title, presence: true
end
