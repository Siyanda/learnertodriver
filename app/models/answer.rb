# frozen_string_literal: true

class Answer < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :questions, through: :responses
end
