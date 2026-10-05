# frozen_string_literal: true

class Admin::QuizzesController < Admin::ResourcesController
  private

  def resource_class = Quiz

  def search_attribute = :title_or_description_cont

  def index_columns = %i[title status duration published_at]

  def show_attributes = %i[title description information status duration published_at]

  def resource_params
    params.expect(quiz: [:title, :description, :information, :duration, :status, :published_at, :cover_image,
                         { question_ids: [] }])
  end
end
