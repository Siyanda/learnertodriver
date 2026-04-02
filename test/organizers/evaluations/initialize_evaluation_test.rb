# frozen_string_literal: true

require 'test_helper'

class Evaluations::InitializeEvaluationTest < ActiveSupport::TestCase
  setup do
    @user     = create(:user)
    @quiz     = create(:quiz)
    @question = create(:question)

    @quiz.questions << @question
  end

  test 'creates a new evaluation with choices when no existing evaluation exists' do
    assert_predicate result[:evaluation], :persisted?
    assert_predicate result[:evaluation], :started?
    assert_equal 1,  result[:evaluation].choices.count
  end

  test 'returns existing in_progress evaluation' do
    existing = create(:evaluation, user: @user, quiz: @quiz, status: :in_progress)

    create(:choice, evaluation: existing, question: @question)

    assert_equal existing.id, result[:evaluation].id
  end

  test 'returns existing started evaluation when no in_progress evaluation exists' do
    existing = create(:evaluation, user: @user, quiz: @quiz, status: :started)

    create(:choice, evaluation: existing, question: @question)

    assert_equal existing.id, result[:evaluation].id
  end

  test 'prefers in_progress evaluation over started evaluation' do
    started     = create(:evaluation, user: @user, quiz: @quiz, status: :started)
    in_progress = create(:evaluation, user: @user, quiz: @quiz, status: :in_progress)

    create(:choice, evaluation: started,     question: @question)
    create(:choice, evaluation: in_progress, question: @question)

    assert_equal in_progress.id, result[:evaluation].id
  end

  test 'creates choices for existing evaluation that has none' do
    existing = create(:evaluation, user: @user, quiz: @quiz, status: :started)

    assert_equal existing.id, result[:evaluation].id
    assert_equal 1, result[:evaluation].choices.count
  end

  test 'does not duplicate choices for evaluation that already has them' do
    existing = create(:evaluation, user: @user, quiz: @quiz, status: :started)

    create(:choice, evaluation: existing, question: @question)

    assert_equal 1, result[:evaluation].choices.count
  end

  test 'creates one choice per question' do
    second_question = create(:question)

    @quiz.questions << second_question

    assert_equal 2, result[:evaluation].choices.count
  end

  private

  def result
    @result ||= Evaluations::InitializeEvaluation.call(@user, @quiz)
  end
end
