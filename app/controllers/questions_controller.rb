# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def show; end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question, notice: t('controllers.notices.create', model: 'Question')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update; end

  def destroy; end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.expect(question: %i[content kind information])
  end
end
