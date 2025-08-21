# frozen_string_literal: true

require 'pagy/extras/bootstrap'

module Admin::ApplicationHelper
  include Pagy::Frontend

  def active_nav_item(*names)
    names.include?(controller_path) ? 'active' : ''
  end
end
