# frozen_string_literal: true

require 'test_helper'

class BackfillEvaluationScoresJobTest < ActiveJob::TestCase
  test 'scores completed evaluations and skips unfinished ones' do
    question = create(:question)
    right    = create(:answer, question:)
    create(:correct_answer, question:, answer: right)

    completed   = create(:evaluation, :completed)
    in_progress = create(:evaluation, :in_progress)
    create(:choice, evaluation: completed,   question:, answer: right, value: 1.0)
    create(:choice, evaluation: completed,   question:, answer: create(:answer, question:), value: 1.0, position: 1)
    create(:choice, evaluation: in_progress, question:, answer: right)

    assert_equal 1, BackfillEvaluationScoresJob.perform_now
    assert_equal 50, completed.reload.score
    assert_equal 0,  in_progress.reload.score
  end
end
