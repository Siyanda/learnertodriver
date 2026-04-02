# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    sequence(:name)        { |n| "Answer #{n}" }
    sequence(:content)     { |n| "Answer content #{n}" }
    sequence(:information) { |n| "Answer information #{n}" }
    value                  { 1 }

    question
  end
end
