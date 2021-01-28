class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_quiz, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @quizzes = Quiz.all
  end

  def show
    @questions = @quiz.questions.random.includes(:answers)
  end

  private

  def set_quiz
    @quiz = Quiz.friendly.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:title)
    end
end
