# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    post
    user
    content { Faker::Lorem.paragraphs }
    status  { :published }
  end
end
