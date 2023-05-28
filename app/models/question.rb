# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :specifications, dependent: :destroy
  has_many :quizzes, through: :specifications
  has_many :responses, dependent: :destroy
  has_many :answers, through: :responses

  enum kind: { single_choice: 0, multiple_choice: 1, long_answer: 2 }

  scope :random, -> { order(Arel::Nodes::NamedFunction.new('RANDOM', [])) }

  validates :content, presence: true
  validates :kind, presence: true
end
