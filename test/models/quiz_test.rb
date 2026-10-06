# frozen_string_literal: true

require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  setup do
    @quiz     = create(:quiz)
    @question = create(:question)
  end

  test 'is valid with valid attributes' do
    assert_predicate @quiz, :valid?
  end

  test 'requires a title, duration, information and description' do
    quiz = Quiz.new(duration: nil)

    assert_not quiz.valid?
    %i[title duration information description].each do |attribute|
      assert_includes quiz.errors[attribute], "can't be blank"
    end
  end

  test 'is invalid with an unknown status' do
    @quiz.status = :archived

    assert_not @quiz.valid?
    assert_includes @quiz.errors[:status], 'is not included in the list'
  end

  test 'has many questions through quiz question linkages' do
    @quiz.questions << @question

    assert_equal [@question], @quiz.reload.questions.to_a
  end

  test 'destroys quiz question linkages but keeps questions when quiz is destroyed' do
    @quiz.questions << @question

    assert_difference({ 'QuizQuestionLinkage.count' => -1, 'Question.count' => 0 }) do
      @quiz.destroy
    end
  end

  test 'with_questions returns only quizzes that have questions' do
    @quiz.questions << [@question, create(:question)]
    empty_quiz = create(:quiz)

    assert_equal [@quiz], Quiz.with_questions.to_a
    assert_not_includes Quiz.with_questions, empty_quiz
  end

  test 'without_questions returns only quizzes that have no questions' do
    @quiz.questions << @question
    empty_quiz = create(:quiz)

    assert_equal [empty_quiz], Quiz.without_questions.to_a
  end

  test 'generates a slug from the title' do
    quiz = create(:quiz, title: 'Road Signs Quiz')

    assert_equal 'road-signs-quiz', quiz.slug
  end
end
