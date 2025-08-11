# frozen_string_literal: true

class Evaluations::InitializeEvaluation
  extend ::LightService::Organizer

  def self.call(params)
    with(
      user: params[:user],
      quiz: params[:quiz]
    ).reduce(actions)
  end

  def self.actions
    [
      Evaluations::FindUserInProgressEvaluation,
      reduce_if(->(ctx) { ctx.evaluation.blank? },               [Evaluations::FindUserStartedEvaluation]),
      reduce_if(->(ctx) { ctx.evaluation.blank? },               [Evaluations::CreateEvaluation]),
      reduce_if(->(ctx) { ctx.evaluation.no_question_choices? }, [Evaluations::CreateEvaluationChoices]),
    ]
  end
end
