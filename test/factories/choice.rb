# frozen_string_literal: true

FactoryBot.define do
  factory :choice do
    association :evaluation
    association :question
    position { 0 }
    value    { 1.0 }
  end
end
