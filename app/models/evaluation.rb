# frozen_string_literal: true

class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  belongs_to :last_choice, class_name: 'Choice', optional: true

  has_many :choices, -> { order(position: :asc) },
           inverse_of: :evaluation,
           dependent:  :destroy

  accepts_nested_attributes_for :choices, allow_destroy: true

  validates :score,  presence: true
  validates :status, presence: true

  enum :status, {
      started:     0,
      in_progress: 1,
      completed:   2
    }, validate: true

  def no_question_choices?
    choices.empty? && quiz.questions.any?
  end

  def last_active_choice = last_choice || choices.first
end
