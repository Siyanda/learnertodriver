class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_quiz, only: %i[show edit update destroy upvote downvote]

  def index
    @quizzes = Quiz.all
  end

  def show
    @questions = @quiz.questions.includes(:answers)
  end

  private

  def set_quiz
    @quiz = Quiz.friendly.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:title)
  end
end
