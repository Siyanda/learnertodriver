# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'registrations', except: [:edit, :update]
    before_action :configure_account_update_params, only: [:update] # rubocop:disable Rails/LexicallyScopedActionFilter

    protected

    def after_update_path_for(_resource)
      edit_user_registration_path
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update,
                                        keys: [:first_name, :last_name, :mobile_country_code,
                                               :mobile_local_phone_number, :identity_number, :avatar,
                                               { documents: [], addresses_attributes: [:id, :title, :region] }])
    end
  end
end
