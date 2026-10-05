# frozen_string_literal: true

class Users::PasswordsController < ApplicationController
  before_action :set_user

  def edit; end

  def update
    result = ::Users::ChangePassword.call(user: @user, session: Current.session, **password_params)

    if result.success?
      redirect_to user_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  # A separate instance, so a failed change doesn't leave an unsaved password
  # digest on Current.user.
  def set_user
    @user = User.find(Current.user.id)
  end

  def password_params
    permitted = params.expect(user: %i[current_password password password_confirmation])

    {
      current_password:      permitted[:current_password],
      password:              permitted[:password],
      password_confirmation: permitted[:password_confirmation]
    }
  end
end
