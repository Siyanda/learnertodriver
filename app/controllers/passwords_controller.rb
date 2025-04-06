# frozen_string_literal: true

class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[edit update]

  layout 'registrations'

  def new; end

  def edit; end

  def create
    if (user = User.find_by(email_address: params[:email_address]))
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: t('.password_reset_instructions_sent')
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: t('.password_reset_success')
    else
      redirect_to edit_password_path(params[:token]), alert: t('.password_mismatch')
    end
  end

  private

  def set_user_by_token
    @user = User.find_by!(password_reset_token: params[:token])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_password_path, alert: t('.reset_link_invalid')
  end
end
