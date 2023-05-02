# frozen_string_literal: true

class Reaction < ApplicationRecord
  belongs_to :answer
  belongs_to :question
  belongs_to :evaluation
end
