# frozen_string_literal: true

class Evaluations::InitializeEvaluation
  extend ::LightService::Organizer

  def self.call(user, quiz)
    with(
      user:,
      quiz:
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
