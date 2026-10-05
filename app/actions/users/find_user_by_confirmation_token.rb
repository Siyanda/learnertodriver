# frozen_string_literal: true

class Users::FindUserByConfirmationToken
  extend ::LightService::Action

  expects  :token
  promises :user

  executed do |ctx|
    ctx.user = User.find_by_token_for(:email_confirmation, ctx.token)

    next if ctx.user

    ctx.fail_and_return!(I18n.t('confirmations.show.invalid'))
  end
end
