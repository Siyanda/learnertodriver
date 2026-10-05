# frozen_string_literal: true

require 'test_helper'

class Dashboards::SummarizeAdminTest < ActiveSupport::TestCase
  test 'counts records and summarises evaluations' do
    completed = create(:evaluation, :completed)
    right     = create(:choice, evaluation: completed)
    create(:evaluation, :started)
    create(:choice, evaluation: completed, position: 1)
    create(:correct_answer, question: right.question, answer: right.answer)

    result = Dashboards::SummarizeAdmin.call

    assert_equal User.count,   result.counts[:users]
    assert_equal 2,            result.counts[:evaluations]
    assert_equal 1,            result.completed_evaluations
    assert_equal 50,           result.completion_rate
    assert_equal 50,           result.average_score
    assert_equal completed.id, result.recent_evaluations.last.id
    assert_operator result.recent_users.size, :<=, 5
  end

  test 'handles an empty database' do
    Evaluation.delete_all

    result = Dashboards::SummarizeAdmin.call

    assert_equal 0, result.completion_rate
    assert_equal 0, result.average_score
  end
end
