# frozen_string_literal: true

class EvaluationsController < ApplicationController
  before_action :set_quiz,           only: %i[new]
  before_action :set_evaluation,     only: %i[show edit update]
  before_action :set_current_choice, only: %i[edit update]

  def show; end

  def new
    result = Evaluations::InitializeEvaluation.call(user: Current.user, quiz: @quiz)

    if result.success?
      redirect_to edit_quiz_evaluation_path(@quiz, result.evaluation)
    else
      redirect_to quizzes_path, alert: result.message, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    authorize! @evaluation

    update_attrs = evaluation_params

    update_attrs.merge!(status: :completed, completed_at: Time.current) if params[:commit].present?

    if @evaluation.update(update_attrs)
      @evaluation.in_progress! if @evaluation.started?

      @current_choice.update(name: @current_choice.question.content, content: @current_choice.answer&.content)
      respond_to do |format|
        format.turbo_stream do
          @current_choice = @evaluation.last_active_choice
          render turbo_stream: turbo_stream.replace('choice_frame', partial: 'form',
                                                                    locals:  { evaluation: @evaluation, current_choice: @current_choice }) # rubocop:disable Layout/LineLength
        end
        format.html do
          redirect_to edit_quiz_evaluation_path(@evaluation.quiz, @evaluation), notice: t('.choice_selection_updated')
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_quiz
    @quiz = Quiz.friendly.find(params[:quiz_id])
  end

  def set_evaluation
    @evaluation = Current.user.evaluations.find(params[:id])
  end

  def set_current_choice
    @current_choice = @evaluation.choices.find_by(id: params[:choice_id]) || @evaluation.last_active_choice
  end

  def evaluation_params
    params.require(:evaluation).permit(:last_choice_id, choices_attributes: %i[id answer_id question_id]) # rubocop:disable Rails/StrongParametersExpect
  end
end
