# frozen_string_literal: true

class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def show; end

  def new; end

  def edit; end

  def create; end

  def update
    if Current.user.update(user_params)
      redirect_to Current.user, notice: t('controllers.notices.update', model: 'User')
    else
      render :edit
    end
  end

  def destroy; end

  private

  def user_params
    params.expect(user: %i[
                    first_name
                    last_name
                    email_address
                    phone_number
                    username
                    title
                    bio
                    links
                    birthday
                  ])
  end
end
