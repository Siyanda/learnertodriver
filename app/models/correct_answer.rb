# frozen_string_literal: true

class CorrectAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :answer
end
