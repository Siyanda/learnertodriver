# frozen_string_literal: true

class Dashboards::FindRecentUsers
  extend ::LightService::Action

  promises :recent_users

  executed do |ctx|
    ctx.recent_users = User.order(created_at: :desc).limit(5)
  end
end
