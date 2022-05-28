# frozen_string_literal: true

class Home < ApplicationRecord
  def self.stats
    totals = {
      all_users: User.all.size,
      all_questions: Question.all.size,
      all_completed_quizzes: Quiz.all.size
    }
  end
end
