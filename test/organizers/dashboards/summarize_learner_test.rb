# frozen_string_literal: true

require 'test_helper'

class Dashboards::SummarizeLearnerTest < ActiveSupport::TestCase
  setup do
    @user     = create(:user)
    @quiz     = create(:quiz, title: 'Signs')
    @question = create(:question)
    @right    = create(:answer, question: @question)
    @wrong    = create(:answer, question: @question)

    @quiz.questions << @question
    create(:correct_answer, question: @question, answer: @right)
  end

  test 'summarises completed evaluations' do
    complete_evaluation(answer: @right)
    complete_evaluation(answer: @wrong)

    result = Dashboards::SummarizeLearner.call(user: @user)

    assert_equal 'all', result.period
    assert_equal({ completed: 2, quizzes_taken: 1, average_score: 50, best_score: 100 }, result.stats)
  end

  test 'builds per-quiz progress including untried quizzes' do
    untried = create(:quiz, title: 'Vehicle controls')
    untried.questions << create(:question)
    complete_evaluation(answer: @right)

    progress = Dashboards::SummarizeLearner.call(user: @user).quiz_progress.index_by(&:quiz)

    assert_equal 1,   progress[@quiz].attempts
    assert_equal 100, progress[@quiz].best_score
    assert_equal 0,   progress[untried].attempts
    assert_nil progress[untried].best_score
  end

  test 'filters by period' do
    complete_evaluation(answer: @right, completed_at: 2.months.ago)
    complete_evaluation(answer: @wrong)

    result = Dashboards::SummarizeLearner.call(user: @user, period: 'month')

    assert_equal 'month', result.period
    assert_equal 1, result.stats[:completed]
    assert_equal 0, result.stats[:best_score]
  end

  test 'falls back to all time for an unknown period' do
    assert_equal 'all', Dashboards::SummarizeLearner.call(user: @user, period: 'decade').period
  end

  test 'finds the test in progress regardless of period' do
    in_progress = create(:evaluation, :in_progress, user: @user, quiz: @quiz, created_at: 1.year.ago)

    result = Dashboards::SummarizeLearner.call(user: @user, period: 'week')

    assert_equal in_progress, result.in_progress_evaluation
  end

  test 'ignores other users' do
    create(:evaluation, :completed, quiz: @quiz)

    result = Dashboards::SummarizeLearner.call(user: @user)

    assert_equal 0, result.stats[:completed]
    assert_nil result.stats[:average_score]
    assert_nil result.in_progress_evaluation
  end

  private

  def complete_evaluation(answer:, completed_at: Time.current)
    create(:evaluation, :completed, user: @user, quiz: @quiz, completed_at:).tap do |evaluation|
      create(:choice, evaluation:, question: @question, answer:)
    end
  end
end
