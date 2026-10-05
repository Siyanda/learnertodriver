# frozen_string_literal: true

class Users::RegisterUser
  extend ::LightService::Organizer

  def self.call(attributes:)
    with(attributes:).reduce(actions)
  end

  def self.actions
    [
      Users::CreateUser,
      Users::SendEmailConfirmation,
    ]
  end
end
