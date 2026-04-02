# frozen_string_literal: true

require "test_helper"

class Evaluations::CreateEvaluationTest < ActiveSupport::TestCase
  test "creates an evaluation for the user and quiz" do
    user = create(:user)
    quiz = create(:quiz)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::InitializeEvaluation)
      .for(Evaluations::CreateEvaluation)
      .with(user:, quiz:, evaluation: nil)

    result = Evaluations::CreateEvaluation.execute(ctx)

    assert_predicate result, :success?
    refute_nil result[:evaluation]
    assert_equal user, result[:evaluation].user
    assert_equal quiz, result[:evaluation].quiz
    assert_predicate result[:evaluation], :started?
    refute_nil result[:evaluation].started_at
  end
end
