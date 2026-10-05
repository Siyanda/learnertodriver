# frozen_string_literal: true

module AdminHelper
  def admin_label(record)
    return if record.nil?

    record.try(:title).presence ||
      record.try(:name).presence ||
      record.try(:content).to_s.truncate(60).presence ||
      "#{record.model_name.human} ##{record.id}"
  end

  def admin_plural(model) = model.model_name.human.pluralize

  def admin_editable? = lookup_context.exists?('form', [controller_path], true)

  def admin_enum_options(model, enum)
    model.public_send(enum.to_s.pluralize).keys.map { |key| [key.humanize, key] }
  end

  def admin_value(record, attribute, truncate: true)
    value = record.public_send(attribute)
    return tag.span('—', class: 'grey-text') if value.nil? || value == ''

    case value
    when ActiveRecord::Base                      then link_to admin_label(value), [:admin, value]
    when ActiveSupport::TimeWithZone, Date, Time then tag.time(l(value, format: :short), datetime: value.iso8601)
    else admin_text(record, attribute, value, truncate:)
    end
  end

  private

  def admin_text(record, attribute, value, truncate:)
    if record.class.defined_enums.key?(attribute.to_s)
      tag.span(value.to_s.humanize, class: "status-badge #{value}")
    elsif truncate
      value.to_s.truncate(60)
    else
      simple_format(value.to_s)
    end
  end
end
