# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    return unless current_user

    redirect_to dashboard_path
  end

  def show; end
end
