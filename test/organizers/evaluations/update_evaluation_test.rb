# frozen_string_literal: true

require 'test_helper'

class Evaluations::UpdateEvaluationTest < ActiveSupport::TestCase
  setup do
    @question   = create(:question)
    @answer     = create(:answer, question: @question)
    @quiz       = create(:quiz)
    @quiz.questions << @question
    @evaluation = create(:evaluation, quiz: @quiz, status: :started)
    @choice     = create(:choice, evaluation: @evaluation, question: @question, answer: @answer)
  end

  test 'updates evaluation and transitions status to in_progress' do
    result = call(params: { score: 2.0 }, commit: nil)

    assert_predicate result[:evaluation].reload, :in_progress?
    assert_equal 2.0, result[:evaluation].reload.score
  end

  test 'completes evaluation when commit is present' do
    freeze_time do
      result = call(params: { score: 5.0 }, commit: 'finish')

      assert_predicate result[:evaluation].reload, :completed?
      assert_equal Time.current, result[:evaluation].reload.completed_at
    end
  end

  test 'sets current_choice from choice_id' do
    result = call(params: {}, commit: nil)

    assert_equal @choice, result[:current_choice]
  end

  test 'fails when evaluation params are invalid' do
    result = call(params: { status: nil }, commit: nil)

    assert_predicate result, :failure?
  end

  private

  def call(params:, commit:)
    Evaluations::UpdateEvaluation.call(
      evaluation: @evaluation,
      params:,
      choice_id:  @choice.id,
      commit:
    )
  end
end
