# frozen_string_literal: true

# == Schema Information
#
# Table name: correct_answers
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  answer_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_correct_answers_on_answer_id                  (answer_id)
#  index_correct_answers_on_question_id                (question_id)
#  index_correct_answers_on_question_id_and_answer_id  (question_id,answer_id) UNIQUE
#
