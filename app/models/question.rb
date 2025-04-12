# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :quiz_question_linkages, dependent: :destroy
  has_many :quizzes, through: :quiz_question_linkages
  has_many :answers, dependent: :destroy

  enum :kind, { single_correct: 0, multiple_correct: 1, text_response: 2 }, validate: true

  scope :random, -> { order(Arel::Nodes::NamedFunction.new('RANDOM', [])) }

  validates :content, presence: true
  validates :kind, presence: true
end
