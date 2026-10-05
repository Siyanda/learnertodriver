# frozen_string_literal: true

require 'test_helper'

class Users::SummarizeProfileTest < ActiveSupport::TestCase
  test 'summarises all-time results and contributions' do
    user       = create(:user)
    evaluation = create(:evaluation, :completed, user:, completed_at: 2.years.ago)
    choice     = create(:choice, evaluation:)
    create(:correct_answer, question: choice.question, answer: choice.answer)
    create(:comment, user:)
    create(:post, user:)

    result = Users::SummarizeProfile.call(user:)

    assert_equal 1,   result.stats[:completed]
    assert_equal 100, result.stats[:best_score]
    assert_equal({ posts: 1, comments: 1 }, result.contributions)
  end
end
