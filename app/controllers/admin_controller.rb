# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_admin

  layout 'admin'

  def authenticate_admin
    return unless Current.user
    return if Current.user.admin?

    flash[:error] = t('.not_authorized')
    redirect_to root_path
  end
end
