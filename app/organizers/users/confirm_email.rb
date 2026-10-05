# frozen_string_literal: true

class Users::ConfirmEmail
  extend ::LightService::Organizer

  def self.call(token:)
    with(token:).reduce(actions)
  end

  def self.actions
    [
      Users::FindUserByConfirmationToken,
      Users::ApplyEmailConfirmation,
    ]
  end
end
