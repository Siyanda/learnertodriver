# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  has_one :correct_answer, dependent: :destroy

  attribute :correct, :boolean

  validates :name,        presence: true
  validates :value,       presence: true
  validates :content,     presence: true
  validates :information, presence: true

  def correct
    value = super
    value.nil? ? correct_answer.present? : value
  end

  alias correct? correct
end
