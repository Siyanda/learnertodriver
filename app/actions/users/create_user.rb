# frozen_string_literal: true

class Users::CreateUser
  extend ::LightService::Action

  expects  :attributes
  promises :user

  executed do |ctx|
    ctx.user = User.new(ctx.attributes)

    next if ctx.user.save

    ctx.fail_and_return!(ctx.user.errors.full_messages.to_sentence)
  end
end
