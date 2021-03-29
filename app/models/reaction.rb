class Reaction < ApplicationRecord
  belongs_to :answer
  belongs_to :question
  belongs_to :quiz
end
