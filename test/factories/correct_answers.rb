# frozen_string_literal: true

FactoryBot.define do
  factory :correct_answer do
    question
    answer
  end
end
