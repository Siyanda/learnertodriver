# frozen_string_literal: true

class Choice < ApplicationRecord
  belongs_to :evaluation
  belongs_to :question
  belongs_to :answer, optional: true

  validates :value,    presence: true
  validates :position, presence: true

  acts_as_list scope: :evaluation
end
