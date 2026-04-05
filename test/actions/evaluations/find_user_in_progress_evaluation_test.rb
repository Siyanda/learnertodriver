# frozen_string_literal: true

require 'test_helper'

class Evaluations::FindUserInProgressEvaluationTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @quiz = create(:quiz)
  end

  test 'finds an in_progress evaluation for the user and quiz' do
    evaluation = create(:evaluation, user: @user, quiz: @quiz, status: :in_progress)
    ctx = execute

    assert_equal evaluation, ctx.evaluation
  end

  test 'returns nil when the user has no in_progress evaluation for the quiz' do
    create(:evaluation, user: @user, quiz: @quiz, status: :started)

    assert_nil execute.evaluation
  end

  test 'does not return an in_progress evaluation belonging to a different user' do
    create(:evaluation, user: create(:user), quiz: @quiz, status: :in_progress)

    assert_nil execute.evaluation
  end

  test 'does not return an in_progress evaluation for a different quiz' do
    create(:evaluation, user: @user, quiz: create(:quiz), status: :in_progress)

    assert_nil execute.evaluation
  end

  test 'action succeeds regardless of whether an evaluation is found' do
    assert_predicate execute, :success?
  end

  private

  def execute
    Evaluations::FindUserInProgressEvaluation.execute(user: @user, quiz: @quiz)
  end
end
