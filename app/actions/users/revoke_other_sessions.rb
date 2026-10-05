# frozen_string_literal: true

class Users::RevokeOtherSessions
  extend ::LightService::Action

  expects :user, :session

  executed do |ctx|
    ctx.user.sessions.where.not(id: ctx.session.id).destroy_all
  end
end
