# frozen_string_literal: true

FactoryBot.define do
  factory :evaluation do
    user
    quiz
    score      { 0.0 }
    status     { :started }
    started_at { DateTime.now }

    trait :started do
      status     { :started }
      started_at { DateTime.now }
    end

    trait :in_progress do
      status     { :in_progress }
      started_at { DateTime.now }
    end

    trait :completed do
      status       { :completed }
      started_at   { 1.hour.ago }
      completed_at { DateTime.now }
    end
  end
end
