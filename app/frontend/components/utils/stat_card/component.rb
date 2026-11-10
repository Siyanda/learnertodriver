# frozen_string_literal: true

class Utils::StatCard::Component < ApplicationViewComponent
  option :label,        required: true
  option :value,        required: true
  option :icon,         default: -> {}
  option :path,         default: -> {}
  option :change,       default: -> {}
  option :change_label, default: -> {}

  private

  def formatted_change = format('%+d%%', change)
end
