# frozen_string_literal: true

class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show edit create update destroy]

  def show
    # view completed
  end

  def new
    @quiz = Quiz.friendly.find(params[:quiz_id])
    @evaluation = Evaluation.new
  end

  def create
    @evaluation = @user.evaluations.new evaluation_params

    if @evaluation.save

      redirect_to root_path, notice: t('.create')
    else
      render action: 'new'
    end
  end

  def update
    # when editing
  end

  def edit
    @evaluation.reactions.build
  end

  private

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def set_user
    @user = User.friendly.find(params[:user_id])
  end

  # TODO: use form object for reactions_attributes
  def evaluation_params
    params.require(:evaluation).permit(:score, :comment, :form_snapshot, :user_id, :created_at, :updated_at,
                                       reactions_attributes: %i[kind value question_id answer_id evaluation_id])
  end
end
