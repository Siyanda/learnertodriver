# == Schema Information
#
# Table name: quiz_question_linkages
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  quiz_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_quiz_question_linkages_on_question_id  (question_id)
#  index_quiz_question_linkages_on_quiz_id      (quiz_id)
#

# frozen_string_literal: true

class QuizQuestionLinkage < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
end
