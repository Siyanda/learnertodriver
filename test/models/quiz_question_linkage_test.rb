# frozen_string_literal: true

require 'test_helper'

class QuizQuestionLinkageTest < ActiveSupport::TestCase
  test 'is valid with valid attributes' do
    assert_predicate build(:quiz_question_linkage), :valid?
  end

  test 'requires a quiz and question' do
    linkage = QuizQuestionLinkage.new

    assert_not linkage.valid?
    assert_includes linkage.errors[:quiz], 'must exist'
    assert_includes linkage.errors[:question], 'must exist'
  end
end
