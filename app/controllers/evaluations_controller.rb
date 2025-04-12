# frozen_string_literal: true

class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: :update

  def new
    @evaluation = Current.user.evaluations.build
    @quiz = Quiz.includes(questions: :answers).references(:questions).friendly.find(params[:quiz_id])
  end

  def create
    @evaluation = Current.user.evaluations.new(evaluation_params)

    if @evaluation.save
      redirect_to root_path, notice: t('controllers.notices.create', model: 'Evaluation')
    else
      redirect_to quizzes_path, notice: t('controllers.notices.error', model: 'Evaluation')
    end
  end

  def update
    @quiz = Quiz.find(params[:quiz_id])
    @evaluation = Evaluation.find(params[:id])

    question_index = params[:evaluation][:current_question_index].to_i
    @quiz.questions[question_index - 1]

    choice_params = params.expect(evaluation: [choices_attributes: %i[answer_id question_id]])
    @evaluation.update(choice_params)

    next_index = question_index + 1
    if next_index <= @quiz.questions.size
      @current_question = @quiz.questions[next_index - 1]
      @current_index = next_index
      render partial: 'question_form',
             locals:  { question: @current_question, index: @current_index, quiz: @quiz, evaluation: @evaluation }
    else
      redirect_to quiz_path(@quiz), notice: t('controllers.notices.create', model: 'Evaluation')
    end
  end

  private

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluation_params
    params.expect(evaluation: [:score, :comment, :form_snapshot, :user_id, :quiz_id,
                               { choices_attributes: %i[name content kind answer_id question_id evaluation_id] }])
  end
end
