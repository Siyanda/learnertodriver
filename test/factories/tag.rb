# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    sequence(:title) { |n| "Tag #{n}" }
    status           { :published }
  end
end
