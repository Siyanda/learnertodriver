# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_admin

  layout 'admin'

  def authenticate_admin
    return if current_user&.admin?

    flash[:error] = t('.not_authorized')
    redirect_to root_path
  end
end
