# frozen_string_literal: true

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  setup do
    @tag = create(:tag)
  end

  test 'is valid with valid attributes' do
    assert_predicate @tag, :valid?
  end

  test 'is invalid without a title' do
    @tag.title = nil

    assert_not @tag.valid?
    assert_includes @tag.errors[:title], "can't be blank"
  end

  test 'is invalid with an unknown status' do
    @tag.status = :draft

    assert_not @tag.valid?
    assert_includes @tag.errors[:status], 'is not included in the list'
  end

  test 'generates a slug from the title' do
    tag = create(:tag, title: 'Road Signs')

    assert_equal 'road-signs', tag.slug
  end

  test 'has many posts and quizzes through taggings' do
    post = create(:post)
    quiz = create(:quiz)
    create(:tagging, tag: @tag, taggable: post)
    create(:tagging, tag: @tag, taggable: quiz)

    assert_equal [post], @tag.posts.to_a
    assert_equal [quiz], @tag.quizzes.to_a
  end

  test 'destroys taggings when destroyed' do
    create(:tagging, tag: @tag)

    assert_difference 'Tagging.count', -1 do
      @tag.destroy
    end
  end
end
