# frozen_string_literal: true

class Choice < ApplicationRecord
  belongs_to :evaluation
  belongs_to :question
  belongs_to :answer, optional: true

  validates :value,    presence: true
  validates :position, presence: true

  acts_as_list scope: :evaluation

  scope :correct, lambda {
    where(
      CorrectAnswer.where(CorrectAnswer.arel_table[:question_id].eq(arel_table[:question_id]))
                   .where(CorrectAnswer.arel_table[:answer_id].eq(arel_table[:answer_id]))
                   .arel.exists
    )
  }
end
