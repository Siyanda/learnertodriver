# frozen_string_literal: true

class Quiz < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :evaluations, dependent: :destroy
  has_many :quiz_question_linkages, dependent: :destroy
  has_many :questions, through: :quiz_question_linkages

  accepts_nested_attributes_for :questions, allow_destroy: true

  has_one_attached :cover_image

  validates :title, presence: true
  validates :duration, presence: true
  validates :information, presence: true
  validates :description, presence: true
end
