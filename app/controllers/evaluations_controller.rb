# frozen_string_literal: true

class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: %i[show edit update destroy]

  def show; end

  def new
    @quiz = Quiz.friendly.find(params[:quiz_id])
    @evaluation = @quiz.evaluations.build
  end

  def edit; end

  def create
    @quiz = Quiz.friendly.find(params[:quiz_id])
    @evaluation = @quiz.evaluations.build(user: current_user)

    if @evaluation.save
      redirect_to quizzes_path, notice: t('.create')
    else
      redirect_to quizzes_path, notice: t('controllers.notices.error', model: 'Evaluation')
    end
  end

  def update; end
  def destroy; end

  private

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluation_params
    params.require(:evaluation).permit(:score, :comment, :form_snapshot, :user_id, :quiz_id,
                                       reactions_attributes:
                                        %i[name content value kind answer_id question_id evaluation_id])
  end
end
