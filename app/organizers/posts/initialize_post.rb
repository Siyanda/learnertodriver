# frozen_string_literal: true

class Posts::InitializePost
  extend ::LightService::Organizer

  def self.call(params)
    with(
      user: params[:post]
    ).reduce(actions)
  end

  def self.actions
    [
      Posts::FindPost,
    ]
  end
end
