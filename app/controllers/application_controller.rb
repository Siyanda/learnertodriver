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

  def email_address_param = User.normalize_value_for(:email_address, params[:email_address].to_s)

  def determine_layout = Current.user ? 'user' : 'guest'
end
