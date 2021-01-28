class Quiz < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :specifications
  has_many :questions, through: :specifications

  enum kind: { general: 0, truck: 1, car: 2, bike: 3 }
end
