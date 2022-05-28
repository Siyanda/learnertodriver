# frozen_string_literal: true

class Specification < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
end
