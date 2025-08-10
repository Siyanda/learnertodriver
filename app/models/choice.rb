# frozen_string_literal: true

class Choice < ApplicationRecord
  belongs_to :evaluation
  belongs_to :question
  belongs_to :answer, optional: true

  acts_as_list scope: :evaluation

  validates :value,    presence: true
  validates :position, presence: true
end
