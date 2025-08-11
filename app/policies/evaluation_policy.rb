# frozen_string_literal: true

class EvaluationPolicy < ApplicationPolicy
  def update?
    owner?
  end
end
