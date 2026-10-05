# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    user
    sequence(:title) { |n| "Page #{n}" }
    content          { Faker::Lorem.paragraphs(number: 2).join("\n\n") }
    status           { :published }
  end
end
