# frozen_string_literal: true

require 'test_helper'

class Evaluations::RecordScoreTest < ActiveSupport::TestCase
  setup { @evaluation = create(:evaluation, :completed) }

  test 'records the percentage of correct choices' do
    choices = [1.0, 1.0, 0.0].each_with_index.map do |value, position|
      create(:choice, evaluation: @evaluation, value:, position:)
    end

    Evaluations::RecordScore.execute(evaluation: @evaluation, choices:)

    assert_in_delta 66.67, @evaluation.reload.score.to_f
  end

  test 'records zero when there are no choices' do
    Evaluations::RecordScore.execute(evaluation: @evaluation, choices: [])

    assert_equal 0, @evaluation.reload.score
  end
end
