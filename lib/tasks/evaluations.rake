# frozen_string_literal: true

namespace :evaluations do
  desc 'Calculate scores for completed evaluations (safe to re-run)'
  task backfill_scores: :environment do
    scored = BackfillEvaluationScoresJob.perform_now

    puts "Scored #{scored} completed evaluation(s)."
  end
end
