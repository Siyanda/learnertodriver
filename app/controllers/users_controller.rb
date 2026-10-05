# frozen_string_literal: true

class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  layout :users_layout

  before_action :redirect_signed_in_user, only: %i[new create]

  rate_limit to: 10, within: 3.minutes, only: :create, with: lambda {
    redirect_to new_user_url, alert: t('.rate_limit_message')
  }

  def show
    @summary = ::Users::SummarizeProfile.call(user: Current.user)
  end

  def new
    @user = User.new
  end

  def edit
    @user = editable_user
  end

  def create
    result = ::Users::RegisterUser.call(attributes: registration_params)
    @user  = result.user

    if result.success?
      start_new_session_for @user
      redirect_to dashboard_path, notice: t('.welcome', name: @user.first_name)
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    @user  = editable_user
    result = ::Users::UpdateProfile.call(user: @user, attributes: user_params)

    if result.success?
      redirect_to user_path, notice: update_notice(result)
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy; end

  private

  # A separate instance, so a failed update doesn't leave unsaved changes
  # (like an invalid avatar) on Current.user, which the layout renders.
  def editable_user = User.find(Current.user.id)

  def update_notice(result)
    return t('.confirm_new_email', email: @user.unconfirmed_email) if result.email_change_requested

    t('controllers.notices.update', model: 'Profile')
  end

  def users_layout = action_name.in?(%w[new create]) ? 'registrations' : determine_layout

  def redirect_signed_in_user
    redirect_to dashboard_path if authenticated?
  end

  def registration_params
    params.expect(user: %i[first_name last_name username email_address password password_confirmation])
  end

  def user_params
    params.expect(user: %i[first_name last_name email_address phone_number username title bio links birthday avatar])
  end
end
