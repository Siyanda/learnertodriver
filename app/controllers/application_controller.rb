# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  include Pagy::Backend
  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  layout :determine_layout

  def not_found!
    raise ActionController::RoutingError, 'Not Found'
  end

  private

  def determine_layout
    Current.user.present? ? 'base' : 'guest'
  end

  def redirect_to_last_page(exception)
    redirect_to url_for(page: exception.pagy.last),
                notice: "Page ##{params[:page]} not found. Showing page #{exception.pagy.last} instead."
  end
end
