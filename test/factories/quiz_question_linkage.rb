# frozen_string_literal: true

FactoryBot.define do
  factory :quiz_question_linkage do
    quiz
    question
  end
end
