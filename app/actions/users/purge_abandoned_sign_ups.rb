# frozen_string_literal: true

class Users::PurgeAbandonedSignUps
  extend ::LightService::Action

  UNCONFIRMED_FOR = 7.days

  promises :purged_count

  executed do |ctx|
    abandoned = User.pending
                    .where(confirmed_at: nil, created_at: ...UNCONFIRMED_FOR.ago)
                    .where.missing(:evaluations, :comments, :posts, :pages)

    ctx.purged_count = abandoned.find_each.count(&:destroy)
  end
end
