# frozen_string_literal: true

class EvaluationsController < ApplicationController
  before_action :require_confirmed_email, only: %i[new edit update]
  before_action :set_quiz,           only: %i[new]
  before_action :set_evaluation,     only: %i[show edit update]
  before_action :set_current_choice, only: %i[edit update]

  def show; end

  def new
    result = Evaluations::InitializeEvaluation.call(user: Current.user, quiz: @quiz)

    if result.success?
      redirect_to edit_quiz_evaluation_path(@quiz, result.evaluation)
    else
      redirect_to quizzes_path, alert: result.message, status: :unprocessable_content
    end
  end

  def edit; end

  def update
    authorize! @evaluation

    result = update_evaluation

    if result.failure?
      flash.now[:alert] = result.message
      render :edit, status: :unprocessable_content
    elsif @evaluation.completed?
      redirect_to quiz_evaluation_path(@evaluation.quiz, @evaluation), notice: t('.completed'), status: :see_other
    else
      respond_with_current_choice(result.current_choice)
    end
  end

  private

  def require_confirmed_email
    return if Current.user.confirmed?

    redirect_to quizzes_path, alert: t('evaluations.confirm_email_first')
  end

  def update_evaluation
    Evaluations::UpdateEvaluation.call(evaluation: @evaluation, params: evaluation_params,
                                       choice_id: params[:choice_id], commit: params[:commit])
  end

  def respond_with_current_choice(current_choice)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('choice_frame', partial: 'form',
                                                                  locals:  { evaluation: @evaluation, current_choice: })
      end
      format.html do
        redirect_to edit_quiz_evaluation_path(@evaluation.quiz, @evaluation), notice: t('.choice_selection_updated')
      end
    end
  end

  def set_quiz
    @quiz = Quiz.friendly.find(params.expect(:quiz_id))
  end

  def set_evaluation
    @evaluation = Current.user.evaluations.find(params.expect(:id))
  end

  def set_current_choice
    @current_choice = @evaluation.choices.find_by(id: params[:choice_id]) || @evaluation.last_active_choice
  end

  def evaluation_params
    params.require(:evaluation).permit(:last_choice_id, choices_attributes: %i[id answer_id question_id]) # rubocop:disable Rails/StrongParametersExpect
  end
end
