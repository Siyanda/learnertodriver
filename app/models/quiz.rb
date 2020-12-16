class Quiz < ApplicationRecord
  has_many :specifications
  has_many :questions, through: :specifications
end
