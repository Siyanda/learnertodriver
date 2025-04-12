# frozen_string_literal: true

class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[index]

  def index
    return unless Current.user

    redirect_to dashboard_path
  end
end
