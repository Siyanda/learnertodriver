# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user
    title        { Faker::Lorem.sentence(word_count: 3) }
    content      { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    status       { :published }
    published_at { nil }
  end
end
