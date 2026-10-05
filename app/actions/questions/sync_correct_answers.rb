# frozen_string_literal: true

class Questions::SyncCorrectAnswers
  extend ::LightService::Action

  expects :question, :correct_answers

  executed do |ctx|
    question   = ctx.question
    answer_ids = ctx.correct_answers.map(&:id)

    question.correct_answers.where.not(answer_id: answer_ids).destroy_all

    answer_ids.each { |answer_id| question.correct_answers.find_or_create_by!(answer_id:) }
  end
end
