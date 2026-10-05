# frozen_string_literal: true

class Dashboards::BuildQuizProgress
  extend ::LightService::Action

  QuizProgress = Data.define(:quiz, :attempts, :best_score, :last_taken_at)

  expects  :evaluations, :scores
  promises :quiz_progress

  executed do |ctx|
    by_quiz = ctx.evaluations.group_by(&:quiz_id)

    ctx.quiz_progress = Quiz.published.with_questions.order(:title).map do |quiz|
      attempts = by_quiz.fetch(quiz.id, [])

      QuizProgress.new(
        quiz:,
        attempts:      attempts.size,
        best_score:    attempts.filter_map { |evaluation| ctx.scores[evaluation.id] }.max,
        last_taken_at: attempts.filter_map(&:completed_at).max
      )
    end
  end
end
