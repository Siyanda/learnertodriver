# frozen_string_literal: true

class AdminConstraint
  def self.matches?(request)
    user = Current.user
    user&.admin?
  end
end
