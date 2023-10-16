# frozen_string_literal: true

class Choice < ApplicationRecord
  belongs_to :answer
  belongs_to :question
  belongs_to :evaluation
end
