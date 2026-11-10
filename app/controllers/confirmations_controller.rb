# frozen_string_literal: true

class ConfirmationsController < ApplicationController
  allow_unauthenticated_access

  layout 'registrations'

  rate_limit to: 5, within: 10.minutes, only: :create, with: lambda {
    redirect_back_or_to new_confirmation_path, alert: t('.rate_limit_message')
  }
  rate_limit to: 3, within: 1.hour, only: :create, by: :recipient_email, name: 'per_email', with: lambda {
    redirect_back_or_to new_confirmation_path, alert: t('.rate_limit_message')
  }

  def show
    result = ::Users::ConfirmEmail.call(token: params.expect(:token))

    if result.success?
      redirect_to (authenticated? ? user_path : new_session_path), notice: t('.confirmed')
    else
      redirect_to new_confirmation_path, alert: result.message
    end
  end

  def new; end

  def create
    user = Current.user || User.find_by(email_address: email_address_param)

    ::Users::SendEmailConfirmation.execute(user:) if user && (!user.confirmed? || user.pending_reconfirmation?)

    redirect_back_or_to (authenticated? ? dashboard_path : new_session_path), notice: t('.sent')
  end

  private

  def email_address_param = User.normalize_value_for(:email_address, params[:email_address].to_s)

  def recipient_email = Current.user&.confirmation_email || email_address_param
end
