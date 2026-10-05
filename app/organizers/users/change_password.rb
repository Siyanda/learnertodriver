# frozen_string_literal: true

class Users::ChangePassword
  extend ::LightService::Organizer

  def self.call(user:, session:, current_password:, password:, password_confirmation:)
    with(user:, session:, current_password:, password:, password_confirmation:).reduce(actions)
  end

  def self.actions
    [
      Users::UpdatePassword,
      Users::RevokeOtherSessions,
    ]
  end
end
