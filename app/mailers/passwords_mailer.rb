# frozen_string_literal: true

class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail subject: t('.password_reset_message'), to: user.email_address
  end
end
