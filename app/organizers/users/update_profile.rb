# frozen_string_literal: true

class Users::UpdateProfile
  extend ::LightService::Organizer

  def self.call(user:, attributes:)
    with(user:, attributes:).reduce(actions)
  end

  def self.actions
    [
      Users::StageEmailChange,
      Users::PersistProfile,
      reduce_if(->(ctx) { ctx.email_change_requested }, [Users::SendEmailConfirmation]),
    ]
  end
end
