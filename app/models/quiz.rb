# frozen_string_literal: true

class Quiz < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :evaluations, dependent: :delete_all

  has_many :specifications, dependent: :delete_all
  has_many :questions, through: :specifications

  accepts_nested_attributes_for :questions, allow_destroy: true

  enum kind: { general: 0, truck: 1, car: 2, bike: 3 }
end
