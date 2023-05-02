# frozen_string_literal: true

class QuizzesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_quiz, only: %i[show edit update destroy upvote downvote]

  def index
    @quizzes = Quiz.all
  end

  def show
    @questions = @quiz.questions.includes(:answers)
    @question_answers_content = @question.answers.pluck(:content)
  end

  def new
    @quiz = Quiz.new
  end

  def edit
    @questions = @quiz.questions.includes(:answers)
  end

  def create
    @quiz = Quiz.new(quiz_params)

    if @quiz.save
      redirect_to @quiz, notice: t('controllers.notices.create', model: 'Quiz')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_quiz
    @quiz = Quiz.friendly.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:title, :kind, :information, :duration, :description, :slug,
                                 questions_attributes: %i[content kind information _destroy])
  end
end
