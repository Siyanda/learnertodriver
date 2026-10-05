# frozen_string_literal: true

class Admin::ResourcesController < AdminController
  include Pagy::Method

  before_action :set_record, only: %i[show edit update destroy]

  helper_method :resource_class, :index_columns, :show_attributes, :search_attribute, :record

  def index
    @q              = scope.ransack(params[:q])
    @q.sorts        = default_sort if @q.sorts.empty?
    @pagy, @records = pagy(:offset, @q.result)
  end

  def show; end

  def new
    @record = resource_class.new
  end

  def edit; end

  def create
    @record = build_record

    if record_saved?
      redirect_to [:admin, @record], notice: t('controllers.notices.create', model: model_label)
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    @record.assign_attributes(resource_params)

    if record_saved?
      redirect_to [:admin, @record], notice: t('controllers.notices.update', model: model_label)
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @record.destroy!

    redirect_to [:admin, resource_class], notice: t('controllers.notices.destroy', model: model_label),
                                          status: :see_other
  rescue ActiveRecord::InvalidForeignKey, ActiveRecord::RecordNotDestroyed
    redirect_to [:admin, @record], alert: t('admin.in_use', model: model_label), status: :see_other
  end

  private

  attr_reader :record

  def resource_class
    raise NotImplementedError
  end

  def resource_params
    raise NotImplementedError
  end

  def scope = resource_class.all

  def build_record = resource_class.new(resource_params)

  def default_sort = 'id desc'

  def index_columns = %i[id]

  def show_attributes = index_columns

  def search_attribute = nil

  def record_saved? = @record.save

  def model_label = resource_class.model_name.human

  def set_record
    @record = finder.find(params.expect(:id))
  end

  def finder
    resource_class.respond_to?(:friendly) ? resource_class.friendly : resource_class
  end
end
