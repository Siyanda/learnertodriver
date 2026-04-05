# frozen_string_literal: true

require 'test_helper'

class Evaluations::PersistEvaluationTest < ActiveSupport::TestCase
  setup do
    @evaluation = create(:evaluation)
  end

  test 'updates the evaluation with the given attributes' do
    ctx = Evaluations::PersistEvaluation.execute(
      evaluation:   @evaluation,
      update_attrs: { score: 5.0 }
    )

    assert_equal 5.0, ctx.evaluation.reload.score
  end

  test 'fails context when evaluation update is invalid' do
    ctx = Evaluations::PersistEvaluation.execute(
      evaluation:   @evaluation,
      update_attrs: { status: nil }
    )

    assert_predicate ctx, :failure?
  end
end
