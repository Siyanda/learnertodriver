# frozen_string_literal: true

require 'test_helper'

class Evaluations::CreateEvaluationChoicesTest < ActiveSupport::TestCase
  setup do
    @user       = create(:user)
    @quiz       = create(:quiz)
    @questions  = create_list(:question, 3, :single_choice)
    @evaluation = create(:evaluation, user: @user, quiz: @quiz)

    @quiz.questions << @questions

    @ctx = Evaluations::CreateEvaluationChoices.execute(evaluation: @evaluation)
  end

  test 'creates one choice per question in the quiz' do
    assert_difference 'Choice.count', @questions.size do
      Evaluations::CreateEvaluationChoices.execute(evaluation: @evaluation)
    end
  end

  test 'promises choices in the context' do
    assert_equal @questions.size, @ctx.choices.size
  end

  test 'associates each choice with the correct question' do
    assert_equal @questions.map(&:id).sort, @ctx.choices.map(&:question_id).sort
  end

  test 'associates each choice with the evaluation' do
    assert(@ctx.choices.all? { |c| c.evaluation_id == @evaluation.id })
  end

  test 'succeeds when the quiz has no questions' do
    empty_evaluation = create(:evaluation, user: @user, quiz: create(:quiz))

    ctx = Evaluations::CreateEvaluationChoices.execute(evaluation: empty_evaluation)

    assert_predicate ctx, :success?
    assert_empty ctx.choices
  end
end
