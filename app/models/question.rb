class Question < ApplicationRecord
  has_many :specifications
  has_many :quizzes, through: :specifications

  has_many :responses
  has_many :answers, through: :responses

  scope :random, -> { order(Arel::Nodes::NamedFunction.new('RANDOM', [])) }
end
