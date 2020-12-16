class Question < ApplicationRecord
  has_many :specifications
  has_many :quizzes, through: :specifications

  has_many :responses
  has_many :answers, through: :responses
end
