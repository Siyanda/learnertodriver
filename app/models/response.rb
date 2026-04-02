# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :answer
  belongs_to :question
end
