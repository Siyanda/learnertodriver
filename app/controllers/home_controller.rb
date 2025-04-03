# frozen_string_literal: true

class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    return if Current.user.blank?

    redirect_to dashboard_path
  end
end
