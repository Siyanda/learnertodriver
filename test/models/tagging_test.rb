# frozen_string_literal: true

require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  test 'is valid with valid attributes' do
    assert_predicate build(:tagging), :valid?
  end

  test 'requires a tag and taggable' do
    tagging = Tagging.new

    assert_not tagging.valid?
    assert_includes tagging.errors[:tag], 'must exist'
    assert_includes tagging.errors[:taggable], 'must exist'
  end

  test 'belongs to a polymorphic taggable' do
    quiz    = create(:quiz)
    tagging = create(:tagging, taggable: quiz)

    assert_equal quiz, tagging.reload.taggable
  end
end
