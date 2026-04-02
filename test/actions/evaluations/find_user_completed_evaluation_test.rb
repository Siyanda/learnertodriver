# frozen_string_literal: true

require 'test_helper'

class Evaluations::FindUserCompletedEvaluationTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @quiz = create(:quiz)
  end

  test 'finds a completed evaluation for the user and quiz' do
    evaluation = create(:evaluation, user: @user, quiz: @quiz, status: :completed)

    ctx = Evaluations::FindUserCompletedEvaluation.execute(user: @user, quiz: @quiz)

    assert_equal evaluation, ctx.evaluation
  end

  test 'returns nil when the user has no completed evaluation for the quiz' do
    create(:evaluation, user: @user, quiz: @quiz, status: :started)

    ctx = Evaluations::FindUserCompletedEvaluation.execute(user: @user, quiz: @quiz)

    assert_nil ctx.evaluation
  end

  test 'does not return a completed evaluation belonging to a different user' do
    other_user = create(:user)
    create(:evaluation, user: other_user, quiz: @quiz, status: :completed)

    ctx = Evaluations::FindUserCompletedEvaluation.execute(user: @user, quiz: @quiz)

    assert_nil ctx.evaluation
  end

  test 'does not return a completed evaluation for a different quiz' do
    other_quiz = create(:quiz)
    create(:evaluation, user: @user, quiz: other_quiz, status: :completed)

    ctx = Evaluations::FindUserCompletedEvaluation.execute(user: @user, quiz: @quiz)

    assert_nil ctx.evaluation
  end

  test 'action succeeds regardless of whether an evaluation is found' do
    ctx = Evaluations::FindUserCompletedEvaluation.execute(user: @user, quiz: @quiz)

    assert_predicate ctx, :success?
  end
end
