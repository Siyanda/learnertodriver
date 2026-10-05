# frozen_string_literal: true

class Users::SendEmailConfirmation
  extend ::LightService::Action

  expects :user

  executed do |ctx|
    ctx.user.update!(confirmation_sent_at: Time.current)

    UsersMailer.email_confirmation(ctx.user).deliver_later
  end
end
