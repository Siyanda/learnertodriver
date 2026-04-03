# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_admin

  layout 'admin'

  private

  def authenticate_admin
    return if Current.user&.admin?

    redirect_to root_path, alert: t('.not_authorized')
  end
end
