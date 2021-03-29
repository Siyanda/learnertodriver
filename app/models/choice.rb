class Choice < ApplicationRecord
  belongs_to :answer
  belongs_to :question
end
