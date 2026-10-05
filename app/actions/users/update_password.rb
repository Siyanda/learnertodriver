# frozen_string_literal: true

class Users::UpdatePassword
  extend ::LightService::Action

  expects :user, :current_password, :password, :password_confirmation

  executed do |ctx|
    user = ctx.user

    # has_secure_password ignores a blank password on update, so check it here.
    if ctx.password.blank?
      user.errors.add(:password, :blank)
      next ctx.fail_and_return!(user.errors.full_messages.to_sentence)
    end

    next if user.update(password_challenge:    ctx.current_password.to_s,
                        password:              ctx.password,
                        password_confirmation: ctx.password_confirmation)

    ctx.fail_and_return!(user.errors.full_messages.to_sentence)
  end
end
