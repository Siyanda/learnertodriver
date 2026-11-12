# frozen_string_literal: true

FactoryBot.define do
  factory :email_suppression do
    email_address { Faker::Internet.email }
    reason        { :hard_bounce }

    trait :spam_complaint do
      reason { :spam_complaint }
    end
  end
end
