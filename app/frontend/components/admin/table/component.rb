# frozen_string_literal: true

class Admin::Table::Component < ApplicationViewComponent
  option :records, required: true
  option :columns, required: true
  option :search,  default: -> {}
  option :actions, default: -> { %i[edit destroy] }

  private

  def header(column)
    label = column_label(column)
    return label unless sortable?(column)

    helpers.sort_link(search, column, label, class: 'sort-link')
  end

  def sortable?(column)
    search.present? && search.klass.ransackable_attributes.include?(column.to_s)
  end

  def column_label(column)
    model_class = search&.klass || records.try(:klass) || records.first&.class
    model_class ? model_class.human_attribute_name(column) : column.to_s.humanize
  end

  def first_cell(record, column)
    link_to helpers.admin_value(record, column), [:admin, record], class: 'profile-link'
  end

  def editable? = actions.include?(:edit)

  def destroyable? = actions.include?(:destroy)

  def actions? = actions.any?
end
