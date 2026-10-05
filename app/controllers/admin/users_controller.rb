# frozen_string_literal: true

class Admin::UsersController < Admin::ResourcesController
  def destroy
    if @record == Current.user
      return redirect_to [:admin, @record], alert:  t('admin.users.self_destroy'),
                                            status: :see_other
    end

    super
  end

  private

  def resource_class = User

  # Accounts created by an admin are trusted, so they skip email confirmation.
  def build_record = super.tap { |user| user.confirmed_at = Time.current }

  def default_sort = 'created_at desc'

  def search_attribute = :first_name_or_last_name_or_username_or_email_address_cont

  def index_columns = %i[username name email_address role status created_at]

  def show_attributes
    %i[username first_name last_name email_address phone_number title bio role status
       sign_in_count last_sign_in_at confirmed_at created_at]
  end

  def resource_params
    permitted = params.expect(user: %i[first_name last_name username email_address phone_number title bio
                                       role status avatar password password_confirmation])
    return permitted if permitted[:password].present?

    permitted.except(:password, :password_confirmation)
  end
end
