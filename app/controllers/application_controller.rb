# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  include BotProtection

  layout :determine_layout

  authorize :user, through: -> { Current.user }

  def not_found!
    raise ActionController::RoutingError, 'Not Found'
  end

  private

  def determine_layout = Current.user ? 'user' : 'guest'
end
