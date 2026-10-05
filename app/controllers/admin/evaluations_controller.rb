# frozen_string_literal: true

class Admin::EvaluationsController < Admin::ResourcesController
  private

  def resource_class = Evaluation

  def scope = Evaluation.includes(:user, :quiz)

  def default_sort = 'created_at desc'

  def index_columns = %i[user quiz status started_at completed_at]

  def show_attributes = %i[user quiz status score started_at completed_at]
end
