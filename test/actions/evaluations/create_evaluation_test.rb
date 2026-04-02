# frozen_string_literal: true

require 'test_helper'

class Evaluations::CreateEvaluationTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @quiz = create(:quiz)
  end

  test 'creates an evaluation associated with the user and quiz' do
    ctx = Evaluations::CreateEvaluation.execute(user: @user, quiz: @quiz, evaluation: nil)

    evaluation = ctx.evaluation
    assert_equal @user, evaluation.user
    assert_equal @quiz, evaluation.quiz
  end

  test 'creates the evaluation with started status' do
    ctx = Evaluations::CreateEvaluation.execute(user: @user, quiz: @quiz, evaluation: nil)

    assert_predicate ctx.evaluation, :started?
  end

  test 'creates the evaluation with a score of 0' do
    ctx = Evaluations::CreateEvaluation.execute(user: @user, quiz: @quiz, evaluation: nil)

    assert_equal 0, ctx.evaluation.score
  end

  test 'sets started_at on the evaluation' do
    freeze_time do
      ctx = Evaluations::CreateEvaluation.execute(user: @user, quiz: @quiz, evaluation: nil)

      assert_equal DateTime.now.to_i, ctx.evaluation.started_at.to_i
    end
  end

  test 'persists the evaluation to the database' do
    assert_difference 'Evaluation.count', 1 do
      Evaluations::CreateEvaluation.execute(user: @user, quiz: @quiz, evaluation: nil)
    end
  end
end
