# frozen_string_literal: true

class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :quiz

  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true

  validates :score, presence: true
  validates :status, presence: true

  enum :status, { started: 0, in_progress: 1, complete: 2 }

  private

  def calulate_average_score
    self.score = choices
                 .pluck(:value)
                 .inject(0.0) { |sum, el| sum + el } / choice_values.size
  end
end
