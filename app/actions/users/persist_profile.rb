# frozen_string_literal: true

class Users::PersistProfile
  extend ::LightService::Action

  expects :user, :attributes

  executed do |ctx|
    next if ctx.user.update(ctx.attributes)

    ctx.fail_and_return!(ctx.user.errors.full_messages.to_sentence)
  end
end
