# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    sequence(:content) { |n| "Question #{n}?" }
    kind               { :single_choice }
  end
end
