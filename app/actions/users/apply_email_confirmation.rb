# frozen_string_literal: true

# Confirms a new account, or swaps in a changed email address once the new
# address has been confirmed.
class Users::ApplyEmailConfirmation
  extend ::LightService::Action

  expects :user

  executed do |ctx|
    user = ctx.user

    user.email_address     = user.unconfirmed_email if user.pending_reconfirmation?
    user.unconfirmed_email = nil
    user.confirmed_at      = Time.current
    user.status            = :active if user.pending?

    next if user.save

    ctx.fail_and_return!(user.errors.full_messages.to_sentence)
  end
end
