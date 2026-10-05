# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  def email_confirmation(user)
    @user  = user
    @token = user.generate_token_for(:email_confirmation)

    mail subject: t('.subject'), to: user.confirmation_email
  end
end
