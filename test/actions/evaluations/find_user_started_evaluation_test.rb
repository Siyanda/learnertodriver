# frozen_string_literal: true

require "test_helper"

class Evaluations::FindUserStartedEvaluationTest < ActiveSupport::TestCase
  test "finds a started evaluation for the user and quiz" do
    user       = create(:user)
    quiz       = create(:quiz)
    evaluation = create(:evaluation, user:, quiz:, status: :started)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::InitializeEvaluation)
      .for(Evaluations::FindUserStartedEvaluation)
      .with(user:, quiz:)

    result = Evaluations::FindUserStartedEvaluation.execute(ctx)

    assert_predicate result, :success?
    assert_equal evaluation, result[:evaluation]
  end

  test "sets evaluation to nil when no started evaluation exists" do
    user = create(:user)
    quiz = create(:quiz)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::InitializeEvaluation)
      .for(Evaluations::FindUserStartedEvaluation)
      .with(user:, quiz:)

    result = Evaluations::FindUserStartedEvaluation.execute(ctx)

    assert_predicate result, :success?
    assert_nil result[:evaluation]
  end
end
