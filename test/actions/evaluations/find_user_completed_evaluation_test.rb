# frozen_string_literal: true

require "test_helper"

class Evaluations::FindUserCompletedEvaluationTest < ActiveSupport::TestCase
  test "finds a completed evaluation for the user and quiz" do
    user       = create(:user)
    quiz       = create(:quiz)
    evaluation = create(:evaluation, user:, quiz:, status: :completed)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::FindUserCompletedEvaluation)
      .for(Evaluations::FindUserCompletedEvaluation)
      .with(user:, quiz:)

    result = Evaluations::FindUserCompletedEvaluation.execute(ctx)

    assert_predicate result, :success?
    assert_equal evaluation, result[:evaluation]
  end

  test "sets evaluation to nil when no completed evaluation exists" do
    user = create(:user)
    quiz = create(:quiz)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::FindUserCompletedEvaluation)
      .for(Evaluations::FindUserCompletedEvaluation)
      .with(user:, quiz:)

    result = Evaluations::FindUserCompletedEvaluation.execute(ctx)

    assert_predicate result, :success?
    assert_nil result[:evaluation]
  end
end
