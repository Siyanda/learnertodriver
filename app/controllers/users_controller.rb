# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index; end

  def show
    @user_posts = @user.posts
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.expect(user: %i[first_name last_name username bio birthday])
  end
end
