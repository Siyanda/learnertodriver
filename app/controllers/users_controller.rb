# frozen_string_literal: true

class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  layout 'registrations', only: [:new, :create]

  def index; end

  def show; end

  def new; end

  def create; end

  private

  def user_params
    params.expect(user: %i[first_name last_name username bio birthday])
  end
end
