# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    notifiable factory: :post
    content    { Faker::Lorem.sentence }
  end
end
