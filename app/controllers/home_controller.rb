# frozen_string_literal: true

class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[index]

  def index
    return if Current.user.blank?

    redirect_to dashboard_path
  end

  def show; end
end
