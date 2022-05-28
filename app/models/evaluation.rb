# frozen_string_literal: true

class Evaluation < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :quiz

  has_many :reactions, dependent: :destroy
  accepts_nested_attributes_for :reactions

  enum kind: { general: 0, truck: 1, car: 2, bike: 3 }
  enum status: { initialized: 0, draft: 1, complete: 2 }

  scope :completed, -> { where(status: 'complete') }
  scope :in_progress, -> { where(status: 'draft') }

  private

  def calulate_average_score
    reaction_values = reactions.pluck(:value)
    avg_scores = reaction_values.inject(0.0) { |sum, el| sum + el } / reaction_values.size
    self.score = (avg_scores).round(2)
  end
end
