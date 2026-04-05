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

    assert_nil execute.evaluation
  end

  test 'does not return an completed evaluation belonging to a different user' do
    create(:evaluation, user: create(:user), quiz: @quiz, status: :completed)

    assert_nil execute.evaluation
  end

  test 'does not return an completed evaluation for a different quiz' do
    create(:evaluation, user: @user, quiz: create(:quiz), status: :completed)

    assert_nil execute.evaluation
  end

  test 'action succeeds regardless of whether an evaluation is found' do
    assert_predicate execute, :success?
  end

  private

  def execute
    Evaluations::FindUserCompletedEvaluation.execute(user: @user, quiz: @quiz)
  end
end
