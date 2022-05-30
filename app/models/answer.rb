# frozen_string_literal: true

class Answer < ApplicationRecord
  has_many :responses, dependent: :delete_all
  has_many :questions, through: :responses
end
