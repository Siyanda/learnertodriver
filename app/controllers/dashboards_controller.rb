class DashboardsController < ApplicationController
  def index
  end

  def show
    if params[:period].present?
      # do something
    else
      params[:period] = "month"
    end

  end
end