# frozen_string_literal: true

class UsersController < ApplicationController
  def show; end

  def new; end

  private

  def user_params
    params.expect(user: %i[first_name last_name username bio birthday])
  end
end
