# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :quiz_question_linkages, dependent: :destroy
  has_many :quizzes, through: :quiz_question_linkages
  has_many :answers, dependent: :destroy

  enum kind: { single_choice: 0, multiple_choice: 1, long_answer: 2 }
  scope :random, -> { order(Arel::Nodes::NamedFunction.new('RANDOM', [])) }

  validates :content, presence: true
  validates :kind, presence: true
end
