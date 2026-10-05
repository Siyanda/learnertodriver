# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    @summary = ::Dashboards::SummarizeLearner.call(user: Current.user, period: params[:period])
  end
end
