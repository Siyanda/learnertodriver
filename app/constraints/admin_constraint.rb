# frozen_string_literal: true

class AdminConstraint
  def self.matches?(request)
    user = User.find_by(id: request.session[:user_id])
    user&.admin?
  end
end
