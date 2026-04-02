# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email_address) { |n| "user#{n}@example.com" }
    sequence(:username)      { |n| "user#{n}" }
    password                 { 'demo1234' }
    first_name               { 'Sadio' }
    last_name                { 'Mané' }
    confirmed_at             { DateTime.now }
    role                     { :subscriber }
    status                   { :active }
  end
end
