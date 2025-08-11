# frozen_string_literal: true

class DashboardsController < ApplicationController
  def index; end

  def show
    @current_user_stats = Current.user
  end
end
