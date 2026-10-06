# frozen_string_literal: true

FactoryBot.define do
  factory :tagging do
    tag
    taggable factory: :post
  end
end
