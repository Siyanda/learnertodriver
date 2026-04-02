# frozen_string_literal: true

require "test_helper"

class Evaluations::FindUserInProgressEvaluationTest < ActiveSupport::TestCase
  test "finds an in_progress evaluation for the user and quiz" do
    user       = create(:user)
    quiz       = create(:quiz)
    evaluation = create(:evaluation, user:, quiz:, status: :in_progress)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::InitializeEvaluation)
      .for(Evaluations::FindUserInProgressEvaluation)
      .with(user:, quiz:)

    result = Evaluations::FindUserInProgressEvaluation.execute(ctx)

    assert_predicate result, :success?
    assert_equal evaluation, result[:evaluation]
  end

  test "sets evaluation to nil when no in_progress evaluation exists" do
    user = create(:user)
    quiz = create(:quiz)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::InitializeEvaluation)
      .for(Evaluations::FindUserInProgressEvaluation)
      .with(user:, quiz:)

    result = Evaluations::FindUserInProgressEvaluation.execute(ctx)

    assert_predicate result, :success?
    assert_nil result[:evaluation]
  end
end
