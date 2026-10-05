# frozen_string_literal: true

class Admin::QuestionsController < Admin::ResourcesController
  def new
    @record = Question.new
    3.times { |index| @record.answers.build(name: "answer_#{index + 1}") }
  end

  private

  def resource_class = Question

  def scope = Question.includes(:answers)

  def search_attribute = :content_or_information_cont

  def index_columns = %i[content kind]

  def show_attributes = %i[content information kind]

  def record_saved?
    result = ::Questions::SaveQuestion.call(question: @record)
    flash.now[:alert] = result.message if result.failure? && result.message.present?

    result.success?
  end

  def resource_params
    params.expect(question: [:content, :information, :kind,
                             { quiz_ids:           [],
                               answers_attributes: [%i[id name content information value correct _destroy]] }])
  end
end
