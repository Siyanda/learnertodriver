# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  validates :name,        presence: true
  validates :value,       presence: true
  validates :content,     presence: true
  validates :information, presence: true
end
