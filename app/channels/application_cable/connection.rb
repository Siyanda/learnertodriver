# frozen_string_literal: true

class ApplicationCable::Connection < ActionCable::Connection::Base
  identified_by :current_user

  def connect
    set_current_user || set_guest_user
  end

  private

  def set_current_user
    return unless (session = Session.find_by(id: cookies.signed[:session_id]))

    self.current_user = session.user
  end

  def set_guest_user
    self.current_user = GuestUser.new
  end
end
