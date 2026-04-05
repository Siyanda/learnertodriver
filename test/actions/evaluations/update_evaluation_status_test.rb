# frozen_string_literal: true

require 'test_helper'

class Evaluations::UpdateEvaluationStatusTest < ActiveSupport::TestCase
  test 'transitions evaluation from started to in_progress' do
    evaluation = create(:evaluation, status: :started)
    Evaluations::UpdateEvaluationStatus.execute(evaluation:)

    assert_predicate evaluation.reload, :in_progress?
  end

  test 'does not change status when evaluation is already in_progress' do
    evaluation = create(:evaluation, status: :in_progress)
    Evaluations::UpdateEvaluationStatus.execute(evaluation:)

    assert_predicate evaluation.reload, :in_progress?
  end

  test 'does not change status when evaluation is completed' do
    evaluation = create(:evaluation, status: :completed)
    Evaluations::UpdateEvaluationStatus.execute(evaluation:)

    assert_predicate evaluation.reload, :completed?
  end
end
