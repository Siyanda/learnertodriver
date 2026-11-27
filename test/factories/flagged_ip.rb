# frozen_string_literal: true

FactoryBot.define do
  factory :flagged_ip do
    ip_address { Faker::Internet.unique.public_ip_v4_address }
    reason     { :honeypot }

    trait :too_fast do
      reason { :too_fast }
    end
  end
end
