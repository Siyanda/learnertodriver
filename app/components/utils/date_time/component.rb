# frozen_string_literal: true

class Utils::DateTime::Component < ApplicationViewComponent
  FORMATS = %i[date time_ago duration].freeze

  option :timestamp
  option :format,     default: -> { :date }
  option :html_class, default: -> { 'date-value' }

  private

  def stimulus_data
    {
      controller:                        stimulus_id,
      "#{stimulus_id}-format-value":     format.to_s,
      "#{stimulus_id}-time-stamp-value": normalized_timestamp
    }
  end

  def normalized_timestamp
    timestamp.respond_to?(:iso8601) ? timestamp.iso8601 : timestamp.to_s
  end
end
