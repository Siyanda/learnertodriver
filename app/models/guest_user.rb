# frozen_string_literal: true

class GuestUser
  def guest?
    true
  end

  def id
    nil
  end

  def name
    'Guest User'
  end
end
