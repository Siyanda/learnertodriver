# frozen_string_literal: true

class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: %i[show edit update destroy]

  def show; end

  def new
    @evaluation = current_user.evaluations.build
    @quiz = Quiz.includes(questions: :answers).references(:questions).friendly.find(params[:quiz_id])
  end

  def edit; end

  def create
    @evaluation = current_user.evaluations.new(evaluation_params)

    if @evaluation.save
      redirect_to root_path, notice: t('controllers.notices.create', model: 'Evaluation')
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
    params.expect(evaluation: [:score, :comment, :form_snapshot, :user_id, :quiz_id,
                               { choices_attributes:
                                                     %i[name content kind answer_id question_id evaluation_id] }])
  end
end
