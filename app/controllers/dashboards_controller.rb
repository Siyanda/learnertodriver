# frozen_string_literal: true

class DashboardsController < ApplicationController
  def index
    if params[:period].present?
      # do something
    else
      params[:period] = 'month'
    end
  end

  def show
    @current_user_stats = Current.user
  end
end
