# frozen_string_literal: true

class Posts::FindPost
  extend ::LightService::Action

  expects  :post

  executed do |ctx|
    post = ctx.post
    post.find(id)
  end
end
