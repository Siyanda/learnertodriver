# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  answer_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_responses_on_answer_id    (answer_id)
#  index_responses_on_question_id  (question_id)
#

# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :answer
  belongs_to :question
end
