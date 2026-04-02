# frozen_string_literal: true

require "test_helper"

class Evaluations::InitializeEvaluationTest < ActiveSupport::TestCase
  test "creates a new evaluation with choices when none exists" do
    user      = create(:user)
    quiz      = create(:quiz)
    questions = create_list(:question, 3)
    questions.each { |q| quiz.questions << q }

    result = Evaluations::InitializeEvaluation.call(user, quiz)

    assert_predicate result, :success?
    refute_nil result[:evaluation]
    assert_predicate result[:evaluation], :started?
    assert_equal 3, result[:evaluation].choices.count
  end

  test "returns an existing in_progress evaluation without creating a new one" do
    user       = create(:user)
    quiz       = create(:quiz)
    evaluation = create(:evaluation, user:, quiz:, status: :in_progress)

    result = Evaluations::InitializeEvaluation.call(user, quiz)

    assert_predicate result, :success?
    assert_equal evaluation.id, result[:evaluation].id
    assert_equal 1, user.evaluations.count
  end

  test "returns an existing started evaluation when no in_progress one exists" do
    user       = create(:user)
    quiz       = create(:quiz)
    evaluation = create(:evaluation, user:, quiz:, status: :started)

    result = Evaluations::InitializeEvaluation.call(user, quiz)

    assert_predicate result, :success?
    assert_equal evaluation.id, result[:evaluation].id
    assert_equal 1, user.evaluations.count
  end
end
