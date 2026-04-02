# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    sequence(:title) { |n| "Quiz #{n}" }
    description      { 'A quiz description' }
    information      { 'Some quiz information' }
    duration         { 3600 }
    status           { :published }
  end
end
