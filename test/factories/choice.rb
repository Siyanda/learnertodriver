# frozen_string_literal: true

FactoryBot.define do
  factory :choice do
    evaluation
    question
    position { 0 }
    value    { 1.0 }
  end
end
