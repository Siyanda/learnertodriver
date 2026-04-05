# frozen_string_literal: true

require 'test_helper'

class Evaluations::UpdateCurrentChoiceTest < ActiveSupport::TestCase
  setup do
    @question   = create(:question)
    @answer     = create(:answer, question: @question)
    @evaluation = create(:evaluation)
    @choice     = create(:choice, evaluation: @evaluation, question: @question, answer: @answer)
  end

  test 'finds choice by choice_id and updates name and content' do
    ctx = Evaluations::UpdateCurrentChoice.execute(evaluation: @evaluation, choice_id: @choice.id)

    assert_equal @question.content, ctx.current_choice.reload.name
    assert_equal @answer.content,   ctx.current_choice.reload.content
  end

  test 'falls back to last_active_choice when choice_id does not match' do
    ctx = Evaluations::UpdateCurrentChoice.execute(evaluation: @evaluation, choice_id: nil)

    assert_equal @choice, ctx.current_choice
  end

  test 'sets current_choice to nil when evaluation has no choices' do
    evaluation = create(:evaluation)
    ctx        = Evaluations::UpdateCurrentChoice.execute(evaluation:, choice_id: nil)

    assert_nil ctx.current_choice
  end

  test 'sets content to nil when choice has no answer' do
    choice = create(:choice, evaluation: @evaluation, question: @question, answer: nil)
    ctx    = Evaluations::UpdateCurrentChoice.execute(evaluation: @evaluation, choice_id: choice.id)

    assert_nil ctx.current_choice.reload.content
  end
end
