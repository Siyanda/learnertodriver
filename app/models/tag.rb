# frozen_string_literal: true

class Tag < ApplicationRecord
  extend FriendlyId

  has_many :posts,   through: :taggings, source: :taggable, source_type: 'Post'
  has_many :quizzes, through: :taggings, source: :taggable, source_type: 'Quiz'

  friendly_id :title, use: :slugged

  enum :status,
       {
         published:   10,
         unpublished: 20,
         restricted:  30,
         removed:     40
       }, validate: true

  validates :title, presence: true
end
