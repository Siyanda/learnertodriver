# frozen_string_literal: true

class Admin::DashboardController < AdminController
  def index
    @summary = ::Dashboards::SummarizeAdmin.call
  end
end
