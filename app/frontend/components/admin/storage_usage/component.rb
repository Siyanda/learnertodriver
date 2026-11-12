# frozen_string_literal: true

class Admin::StorageUsage::Component < ApplicationViewComponent
  SERIES_COUNT = 6

  option :modules, required: true
  option :bytes,   required: true
  option :files,   required: true

  private

  def series_class(index) = "series-#{index % SERIES_COUNT}"

  def share(storage_module)
    return '0%' if bytes.zero?

    "#{(storage_module.bytes * 100.0 / bytes).round}%"
  end

  def growth(storage_module)
    return '—' if storage_module.growth.nil?

    format('%+.1f%%', storage_module.growth)
  end

  def summary = "#{number_to_human_size(bytes)} used across #{pluralize(files, 'file')}"
end
