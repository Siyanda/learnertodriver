# frozen_string_literal: true

class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :quiz

  has_many :reactions, dependent: :destroy
  accepts_nested_attributes_for :reactions, :allow_destroy

  validates :score, presence: true
  validates :status, presence: true

  enum status: { started: 0, in_progress: 1, complete: 2 }

  private

  def calulate_average_score
    self.score = reactions
                 .pluck(:value)
                 .inject(0.0) { |sum, el| sum + el } / reaction_values.size
  end
end
