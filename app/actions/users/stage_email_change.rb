# frozen_string_literal: true

# Holds a changed email address in `unconfirmed_email` until it is confirmed,
# so the account keeps working with the old address in the meantime.
class Users::StageEmailChange
  extend ::LightService::Action

  expects  :user, :attributes
  promises :email_change_requested

  executed do |ctx|
    new_email      = ctx.attributes[:email_address].to_s.strip.downcase
    ctx.attributes = ctx.attributes.except(:email_address)

    ctx.email_change_requested = new_email.present? && new_email != ctx.user.email_address &&
                                 new_email != ctx.user.unconfirmed_email

    if ctx.email_change_requested
      ctx.attributes = ctx.attributes.merge(unconfirmed_email: new_email)
    elsif new_email == ctx.user.email_address
      ctx.attributes = ctx.attributes.merge(unconfirmed_email: nil)
    end
  end
end
