# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'sadio.mane@senegal.com' }
    password { 'demo1234' }
    first_name { 'Sadio' }
    last_name { 'Mané' }
    username { 'sadio_mane' }
    confirmed_at { DateTime.now }
  end
end
