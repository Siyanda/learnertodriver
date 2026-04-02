# frozen_string_literal: true

class QuizQuestionLinkage < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
end
