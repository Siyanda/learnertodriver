# frozen_string_literal: true

class SessionsController < ApplicationController
  layout 'registrations'

  allow_unauthenticated_access only: %i[new create]

  rate_limit to: 10, within: 3.minutes, only: :create, with: lambda {
    redirect_to new_session_url, alert: t('.rate_limit_message')
  }

  def new; end

  def create
    if (user = User.authenticate_by(params.permit(:email_address, :password)))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: t('.email_password_mismatch')
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
