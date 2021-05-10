class Quiz < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :evaluations

  has_many :specifications
  has_many :questions, through: :specifications

  accepts_nested_attributes_for :questions, allow_destroy: true

  # has_one_attached :cover_image

  enum kind: { general: 0, truck: 1, car: 2, bike: 3 }
end
