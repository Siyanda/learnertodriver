# frozen_string_literal: true

class Posts::InitializePost
  extend ::LightService::Organizer

  def self.call(user:)
    with(
      user:
    ).reduce(actions)
  end

  def self.actions
    [
      #
    ]
  end
end
