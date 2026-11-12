# frozen_string_literal: true

class Admin::DirectUploadsController < ActiveStorage::DirectUploadsController
  include Authentication

  before_action :authenticate_admin

  private

  def authenticate_admin
    head :forbidden unless Current.user.admin?
  end
end
