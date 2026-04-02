# frozen_string_literal: true

require "test_helper"

class Evaluations::CreateEvaluationChoicesTest < ActiveSupport::TestCase
  test "creates a choice for each question in the evaluation's quiz" do
    quiz       = create(:quiz)
    questions  = create_list(:question, 3)
    questions.each { |q| quiz.questions << q }
    evaluation = create(:evaluation, quiz:)

    ctx = LightService::Testing::ContextFactory
      .make_from(Evaluations::InitializeEvaluation)
      .for(Evaluations::CreateEvaluationChoices)
      .with(evaluation:)

    result = Evaluations::CreateEvaluationChoices.execute(ctx)

    assert_predicate result, :success?
    assert_equal 3, result[:choices].size
    assert_equal questions.map(&:id).sort, result[:choices].map(&:question_id).sort
  end

  test "fails when a choice cannot be created" do
    evaluation = create(:evaluation)

    evaluation.stub(:quiz, Minitest::Mock.new.tap { |m|
      m.expect(:questions, Minitest::Mock.new.tap { |q| q.expect(:ids, [ nil ]) })
    }) do
      ctx = LightService::Testing::ContextFactory
        .make_from(Evaluations::InitializeEvaluation)
        .for(Evaluations::CreateEvaluationChoices)
        .with(evaluation:)

      result = Evaluations::CreateEvaluationChoices.execute(ctx)

      assert_predicate result, :failure?
      assert_match(/Failed to create choices/, result.message)
    end
  end
end
