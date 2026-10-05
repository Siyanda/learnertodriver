# frozen_string_literal: true

class Dashboards::CountRecords
  extend ::LightService::Action

  promises :counts

  executed do |ctx|
    ctx.counts = {
      users:       User.count,
      quizzes:     Quiz.count,
      questions:   Question.count,
      evaluations: Evaluation.count,
      posts:       Post.count
    }
  end
end
