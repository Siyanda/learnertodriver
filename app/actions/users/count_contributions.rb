# frozen_string_literal: true

class Users::CountContributions
  extend ::LightService::Action

  expects  :user
  promises :contributions

  executed do |ctx|
    ctx.contributions = {
      posts:    ctx.user.posts.count,
      comments: ctx.user.comments.count
    }
  end
end
